/* 
 * Copyright (C) 2004 Andrew Beekhof <andrew@beekhof.net>
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
#ifndef XMLUTILS_H
#define XMLUTILS_H

#include <portability.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>

#include <clplumbing/ipc.h>
#include <clplumbing/cl_log.h> 
#include <libxml/tree.h> 

extern int add_xmlnode_to_cib(xmlNodePtr cib, const char * node_path, xmlNodePtr xml_node);
extern void copy_in_properties(xmlNodePtr src, xmlNodePtr target);
extern xmlNodePtr xmlLinkedCopyNoSiblings(xmlNodePtr src, int recursive);

extern xmlNodePtr find_xmlnode(xmlNodePtr cib, const char * node_path);
extern xmlNodePtr find_entity(xmlNodePtr parent, const char *node_name, const char *id, gboolean siblings);
extern xmlNodePtr find_entity_nested(xmlNodePtr parent, const char *node_name, const char *elem_filter_name, const char *elem_filter_value, const char *id, gboolean siblings);
extern xmlDocPtr  createTree(void);
extern xmlNodePtr find_xmlnode_nested(xmlNodePtr root, const char **search_path, int len);

extern char * dump_xml(xmlNodePtr msg);
extern char * dump_xml_node(xmlNodePtr msg, gboolean whole_doc);
extern void free_xml(xmlNodePtr a_node);
extern int add_node_copy(xmlNodePtr cib, const char *node_path, xmlNodePtr xml_node);
extern xmlAttrPtr set_xml_property_copy(xmlNodePtr node, const xmlChar *name, const xmlChar *value);
void xml_message_debug(xmlNodePtr msg);


#endif
