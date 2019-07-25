/*
 * Copyright 2019 the Pacemaker project contributors
 *
 * The version control history for this file may have further details.
 *
 * This source code is licensed under the GNU Lesser General Public License
 * version 2.1 or later (LGPLv2.1+) WITHOUT ANY WARRANTY.
 */

#include <config.h>
#include <glib.h>

#include <crm/common/cmdline_internal.h>
#include <crm/common/util.h>

static gboolean
bump_verbosity(const gchar *option_name, const gchar *optarg, gpointer data, GError **error) {
    pcmk__common_args_t *common_args = (pcmk__common_args_t *) data;
    common_args->verbosity++;
    return TRUE;
}

static void
free_common_args(gpointer data) {
    pcmk__common_args_t *common_args = (pcmk__common_args_t *) data;

    free(common_args->summary);
    free(common_args->output_ty);
    free(common_args->output_ty_desc);
    free(common_args->output_dest);
}

GOptionContext *
pcmk__build_arg_context(pcmk__common_args_t *common_args, const char *fmts) {
    char *desc = crm_strdup_printf("Report bugs to %s\n", PACKAGE_BUGREPORT);
    GOptionContext *context;
    GOptionGroup *main_group;

    GOptionEntry main_entries[5] = {
        { "version", '$', 0, G_OPTION_ARG_NONE, &(common_args->version),
          "Display version information and exit.",
          NULL },
        { "verbose", 'V', G_OPTION_FLAG_NO_ARG, G_OPTION_ARG_CALLBACK, bump_verbosity,
          "Increase debug output (may be specified multiple times).",
          NULL },
        { "output-as", 0, 0, G_OPTION_ARG_STRING, &(common_args->output_ty),
          NULL,
          "FORMAT" },
        { "output-to", 0, 0, G_OPTION_ARG_STRING, &(common_args->output_dest),
          "Specify the destination for output, \"-\" for stdout or a filename.", "DEST" },

        { NULL }
    };

    common_args->output_ty_desc = crm_strdup_printf("Specify the format for output, one of: %s", fmts);
    main_entries[2].description = common_args->output_ty_desc;

    main_group = g_option_group_new(NULL, "Application Options:", NULL, common_args, free_common_args);
    g_option_group_add_entries(main_group, main_entries);

    context = g_option_context_new(NULL);
    g_option_context_set_summary(context, common_args->summary);
    g_option_context_set_description(context, desc);
    g_option_context_set_main_group(context, main_group);

    free(desc);

    return context;
}

char **
pcmk__cmdline_preproc(int argc, char **argv, const char *special) {
    char **retval = NULL;
    GPtrArray *arr = g_ptr_array_new();
    bool saw_dash_dash = false;

    for (int i = 0; i < argc; i++) {
        /* If this is the first time we saw "--" in the command line, set
         * a flag so we know to just copy everything after it over.  We also
         * want to copy the "--" over so whatever actually parses the command
         * line when we're done knows where arguments end.
         */
        if (saw_dash_dash == false && strcmp(argv[i], "--") == 0) {
            saw_dash_dash = true;
        }

        if (saw_dash_dash == true) {
            g_ptr_array_add(arr, strdup(argv[i]));
            continue;
        }

        /* This is a short argument, or perhaps several.  Iterate over it
         * and explode them out into individual arguments.
         */
        if (g_str_has_prefix(argv[i], "-") && !g_str_has_prefix(argv[i], "--")) {
            /* Skip over leading dash */
            char *ch = argv[i]+1;

            while (*ch != '\0') {
                /* This is a special short argument that takes an option.  getopt
                 * allows values to be interspersed with a list of arguments, but
                 * glib does not.  Grab both the argument and its value and
                 * separate them into a new argument.
                 */
                if (strchr(special, *ch) != NULL) {
                    /* The argument does not occur at the end of this string of
                     * arguments.  Take everything through the end as its value.
                     */
                    if (*(ch+1) != '\0') {
                        g_ptr_array_add(arr, (gpointer) crm_strdup_printf("-%c", *ch));
                        g_ptr_array_add(arr, strdup(ch+1));
                        break;

                    /* The argument occurs at the end of this string.  Hopefully
                     * whatever comes next in argv is its value.  It may not be,
                     * but that is not for us to decide.
                     */
                    } else {
                        g_ptr_array_add(arr, (gpointer) crm_strdup_printf("-%c", *ch));
                        ch++;
                    }

                /* This is a regular short argument.  Just copy it over. */
                } else {
                    g_ptr_array_add(arr, (gpointer) crm_strdup_printf("-%c", *ch));
                    ch++;
                }
            }

        /* This is a long argument, or an option, or something else.
         * Copy it over - everything else is copied, so this keeps it easy for
         * the caller to know what to do with the memory when it's done.
         */
        } else {
            g_ptr_array_add(arr, strdup(argv[i]));
        }
    }

    /* Convert the GPtrArray into a char **, which the command line parsing
     * code knows how to deal with.  Then we can free the array (but not its
     * contents).
     */
    retval = calloc(arr->len+1, sizeof(char *));
    for (int i = 0; i < arr->len; i++) {
        retval [i] = (char *) g_ptr_array_index(arr, i);
    }

    g_ptr_array_free(arr, FALSE);

    return retval;
}
