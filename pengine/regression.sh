#!/bin/bash

 # Copyright (C) 2004 Andrew Beekhof <andrew@beekhof.net>
 # 
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public
 # License as published by the Free Software Foundation; either
 # version 2 of the License, or (at your option) any later version.
 # 
 # This software is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 # General Public License for more details.
 # 
 # You should have received a copy of the GNU General Public
 # License along with this library; if not, write to the Free Software
 # Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #

core=`dirname $0`
. $core/regression.core.sh
io_dir=$test_home/test10

create_mode="true"
info Generating test outputs for these tests...
# do_test file description

info Done.
echo ""

info Performing the following tests from $io_dir
create_mode="false"

echo ""
do_test simple1 "Offline     "
do_test simple2 "Start       "
do_test simple3 "Start 2     "
do_test simple4 "Start Failed"
do_test simple6 "Stop Start  "
do_test simple7 "Shutdown    "
#do_test simple8 "Stonith	"
#do_test simple9 "Lower version"
#do_test simple10 "Higher version"
do_test simple11 "Priority (ne)"
do_test simple12 "Priority (eq)"
do_test simple8 "Stickiness"

echo ""
do_test group1 "Group		"
do_test group2 "Group + Native	"
do_test group3 "Group + Group	"
do_test group4 "Group + Native (nothing)"
do_test group5 "Group + Native (move)   "
do_test group6 "Group + Group (move)    "
do_test group7 "Group colocation"
do_test group13 "Group colocation (cant run)"
do_test group8 "Group anti-colocation"
do_test group9 "Group recovery"
do_test group10 "Group partial recovery"
do_test group11 "Group target_role"
do_test group14 "Group stop (graph terminated)"
do_test group15 "-ve group colocation"
do_test bug-1573 "Partial stop of a group with two children"
do_test bug-1718 "Mandatory group ordering - Stop group_FUN"
do_test bug-lf-2613 "Move group on failure"
do_test bug-lf-2619 "Move group on clone failure"

echo ""
do_test rsc_dep1 "Must not     "
do_test rsc_dep3 "Must         "
do_test rsc_dep5 "Must not 3   "
do_test rsc_dep7 "Must 3       "
do_test rsc_dep10 "Must (but cant)"
do_test rsc_dep2  "Must (running) "
do_test rsc_dep8  "Must (running : alt) "
do_test rsc_dep4  "Must (running + move)"
do_test asymmetric "Asymmetric - require explicit location constraints"

echo ""
do_test orphan-0 "Orphan ignore"
do_test orphan-1 "Orphan stop"

echo ""
do_test params-0 "Params: No change"
do_test params-1 "Params: Changed"
do_test params-2 "Params: Resource definition"
do_test params-4 "Params: Reload"
do_test params-5 "Params: Restart based on probe digest"
do_test novell-251689 "Resource definition change + target_role=stopped"
do_test bug-lf-2106 "Restart all anonymous clone instances after config change"
do_test params-6 "Params: Detect reload in previously migrated resource"

echo ""
do_test target-0 "Target Role : baseline"
do_test target-1 "Target Role : master"
do_test target-2 "Target Role : invalid"

echo ""
do_test domain "Failover domains"
do_test base-score "Set a node's default score for all nodes"

echo ""
do_test date-1 "Dates" -t "2005-020"
do_test date-2 "Date Spec - Pass" -t "2005-020T12:30"
do_test date-3 "Date Spec - Fail" -t "2005-020T11:30"
do_test probe-0 "Probe (anon clone)"
do_test probe-1 "Pending Probe"
do_test probe-2 "Correctly re-probe cloned groups"
do_test probe-3 "Probe (pending node)"
do_test probe-4 "Probe (pending node + stopped resource)" --rc 4
do_test standby "Standby"
do_test comments "Comments"


echo ""
do_test order1 "Order start 1     "
do_test order2 "Order start 2     "
do_test order3 "Order stop	  "
do_test order4 "Order (multiple)  "
do_test order5 "Order (move)  "
do_test order6 "Order (move w/ restart)  "
do_test order7 "Order (manditory)  "
do_test order-optional "Order (score=0)  "
do_test order-required "Order (score=INFINITY)  "
do_test bug-lf-2171 "Prevent group start when clone is stopped"
do_test order-clone "Clone ordering should be able to prevent startup of dependant clones"
do_test order-sets "Ordering for resource sets"
do_test order-serialize "Serialize resources without inhibiting migration"
do_test order-serialize-set "Serialize a set of resources without inhibiting migration"
do_test clone-order-primitive "Order clone start after a primitive"
do_test order-optional-keyword "Order (optional keyword)"
do_test order-mandatory "Order (mandatory keyword)"
do_test bug-lf-2493 "Don't imply colocation requirements when applying ordering constraints with clones"
# This test emits an error log and thus upsets the test suite; even
# though it explicitly aims to test an error leg. FIXME
# do_test order-wrong-kind "Order (error)"

echo ""
do_test coloc-loop "Colocation - loop"
do_test coloc-many-one "Colocation - many-to-one"
do_test coloc-list "Colocation - many-to-one with list"
do_test coloc-group "Colocation - groups"
do_test coloc-slave-anti "Anti-colocation with slave shouldn't prevent master colocation"
do_test coloc-attr "Colocation based on node attributes"
do_test coloc-negative-group "Negative colocation with a group"
do_test coloc-intra-set "Intra-set colocation"
do_test bug-lf-2435 "Colocation sets with a negative score"
do_test coloc-clone-stays-active "Ensure clones don't get stopped/demoted because a dependant must stop"

echo ""
do_test rsc-sets-seq-true "Resource Sets - sequential=false"
do_test rsc-sets-seq-false "Resource Sets - sequential=true"
do_test rsc-sets-clone "Resource Sets - Clone"
do_test rsc-sets-master "Resource Sets - Master"
do_test rsc-sets-clone-1 "Resource Sets - Clone (lf#2404)"

#echo ""
#do_test agent1 "version: lt (empty)"
#do_test agent2 "version: eq	"
#do_test agent3 "version: gt	"

echo ""
do_test attrs1 "string: eq (and)     "
do_test attrs2 "string: lt / gt (and)"
do_test attrs3 "string: ne (or)      "
do_test attrs4 "string: exists       "
do_test attrs5 "string: not_exists   "
do_test attrs6 "is_dc: true          "
do_test attrs7 "is_dc: false         "
do_test attrs8 "score_attribute      "

echo ""
do_test mon-rsc-1 "Schedule Monitor - start"
do_test mon-rsc-2 "Schedule Monitor - move "
do_test mon-rsc-3 "Schedule Monitor - pending start     "
do_test mon-rsc-4 "Schedule Monitor - move/pending start"

echo ""
do_test rec-rsc-0 "Resource Recover - no start     "
do_test rec-rsc-1 "Resource Recover - start        "
do_test rec-rsc-2 "Resource Recover - monitor      "
do_test rec-rsc-3 "Resource Recover - stop - ignore"
do_test rec-rsc-4 "Resource Recover - stop - block "
do_test rec-rsc-5 "Resource Recover - stop - fence "
do_test rec-rsc-6 "Resource Recover - multiple - restart"
do_test rec-rsc-7 "Resource Recover - multiple - stop   "
do_test rec-rsc-8 "Resource Recover - multiple - block  "
do_test rec-rsc-9 "Resource Recover - group/group"

echo ""
do_test quorum-1 "No quorum - ignore"
do_test quorum-2 "No quorum - freeze"
do_test quorum-3 "No quorum - stop  "
do_test quorum-4 "No quorum - start anyway"
do_test quorum-5 "No quorum - start anyway (group)"
do_test quorum-6 "No quorum - start anyway (clone)"

echo ""
do_test rec-node-1 "Node Recover - Startup   - no fence"
do_test rec-node-2 "Node Recover - Startup   - fence   "
do_test rec-node-3 "Node Recover - HA down   - no fence"
do_test rec-node-4 "Node Recover - HA down   - fence   "
do_test rec-node-5 "Node Recover - CRM down  - no fence"
do_test rec-node-6 "Node Recover - CRM down  - fence   "
do_test rec-node-7 "Node Recover - no quorum - ignore  "
do_test rec-node-8 "Node Recover - no quorum - freeze  "
do_test rec-node-9 "Node Recover - no quorum - stop    "
do_test rec-node-10 "Node Recover - no quorum - stop w/fence"
do_test rec-node-11 "Node Recover - CRM down w/ group - fence   "
do_test rec-node-12 "Node Recover - nothing active - fence   "
do_test rec-node-13 "Node Recover - failed resource + shutdown - fence   "
do_test rec-node-15 "Node Recover - unknown lrm section"
do_test rec-node-14 "Serialize all stonith's"

echo ""
do_test multi1 "Multiple Active (stop/start)"

echo ""
do_test migrate-begin     "Normal migration"
do_test migrate-success   "Completed migration"
do_test migrate-partial-1 "Completed migration, missing stop on source"
do_test migrate-partial-2 "Successful migrate_to only"
do_test migrate-partial-3 "Successful migrate_to only, target down"

do_test migrate-fail-2 "Failed migrate_from"
do_test migrate-fail-3 "Failed migrate_from + stop on source"
do_test migrate-fail-4 "Failed migrate_from + stop on target - ideally we wouldn't need to re-stop on target"
do_test migrate-fail-5 "Failed migrate_from + stop on source and target"

do_test migrate-fail-6 "Failed migrate_to"
do_test migrate-fail-7 "Failed migrate_to + stop on source"
do_test migrate-fail-8 "Failed migrate_to + stop on target - ideally we wouldn't need to re-stop on target"
do_test migrate-fail-9 "Failed migrate_to + stop on source and target"

do_test migrate-stop "Migration in a stopping stack"
do_test migrate-start "Migration in a starting stack"
do_test migrate-stop_start "Migration in a restarting stack"
do_test migrate-stop-complex "Migration in a complex stopping stack"
do_test migrate-start-complex "Migration in a complex starting stack"
do_test migrate-stop-start-complex "Migration in a complex moving stack"

do_test migrate-1 "Migrate (migrate)"
do_test migrate-2 "Migrate (stable)"
do_test migrate-3 "Migrate (failed migrate_to)"
do_test migrate-4 "Migrate (failed migrate_from)"
do_test novell-252693 "Migration in a stopping stack"
do_test novell-252693-2 "Migration in a starting stack"
do_test novell-252693-3 "Non-Migration in a starting and stopping stack"
do_test bug-1820 "Migration in a group"
do_test bug-1820-1 "Non-migration in a group"
do_test migrate-5 "Primitive migration with a clone"
do_test migrate-fencing "Migration after Fencing"

#echo ""
#do_test complex1 "Complex	"

do_test bug-lf-2422 "Dependancy on partially active group - stop ocfs:*"

echo ""
do_test clone-anon-probe-1 "Probe the correct (anonymous) clone instance for each node"
do_test clone-anon-probe-2 "Avoid needless re-probing of anonymous clones"
do_test clone-anon-failcount "Merge failcounts for anonymous clones"
do_test inc0 "Incarnation start" 
do_test inc1 "Incarnation start order" 
do_test inc2 "Incarnation silent restart, stop, move"
do_test inc3 "Inter-incarnation ordering, silent restart, stop, move"
do_test inc4 "Inter-incarnation ordering, silent restart, stop, move (ordered)"
do_test inc5 "Inter-incarnation ordering, silent restart, stop, move (restart 1)"
do_test inc6 "Inter-incarnation ordering, silent restart, stop, move (restart 2)"
do_test inc7 "Clone colocation"
do_test inc8 "Clone anti-colocation"
do_test inc9 "Non-unique clone"
do_test inc10 "Non-unique clone (stop)"
do_test inc11 "Primitive colocation with clones" 
do_test inc12 "Clone shutdown" 
do_test cloned-group "Make sure only the correct number of cloned groups are started"
do_test clone-no-shuffle "Dont prioritize allocation of instances that must be moved"
do_test clone-max-zero "Orphan processing with clone-max=0"
do_test clone-anon-dup "Bug LF#2087 - Correctly parse the state of anonymous clones that are active more than once per node"
do_test bug-lf-2160 "Dont shuffle clones due to colocation"
do_test bug-lf-2213 "clone-node-max enforcement for cloned groups"
do_test bug-lf-2153 "Clone ordering constraints"
do_test bug-lf-2361 "Ensure clones observe mandatory ordering constraints if the LHS is unrunnable"
do_test bug-lf-2317 "Avoid needless restart of primitive depending on a clone"
do_test clone-colocate-instance-1 "Colocation with a specific clone instance (negative example)"
do_test clone-colocate-instance-2 "Colocation with a specific clone instance"
do_test clone-order-instance "Ordering with specific clone instances"
do_test bug-lf-2453 "Enforce mandatory clone ordering without colocation"
do_test bug-lf-2508 "Correctly reconstruct the status of anonymous cloned groups" 
do_test bug-lf-2544 "Balanced clone placement"
do_test bug-lf-2445 "Redistribute clones with node-max > 1 and stickiness = 0"
do_test bug-lf-2574 "Avoid clone shuffle"
do_test bug-lf-2581 "Avoid group restart due to unrelated clone (re)start"

echo ""
do_test master-0 "Stopped -> Slave"
do_test master-1 "Stopped -> Promote"
do_test master-2 "Stopped -> Promote : notify"
do_test master-3 "Stopped -> Promote : master location"
do_test master-4 "Started -> Promote : master location"
do_test master-5 "Promoted -> Promoted"
do_test master-6 "Promoted -> Promoted (2)"
do_test master-7 "Promoted -> Fenced"
do_test master-8 "Promoted -> Fenced -> Moved"
do_test master-9 "Stopped + Promotable + No quorum"
do_test master-10 "Stopped -> Promotable : notify with monitor"
do_test master-11 "Stopped -> Promote : colocation"
do_test novell-239082 "Demote/Promote ordering"
do_test novell-239087 "Stable master placement"
do_test master-12 "Promotion based solely on rsc_location constraints"
do_test master-13 "Include preferences of colocated resources when placing master"
do_test master-demote "Ordering when actions depends on demoting a slave resource" 
do_test master-ordering "Prevent resources from starting that need a master"
do_test bug-1765 "Master-Master Colocation (dont stop the slaves)"
do_test master-group "Promotion of cloned groups"
do_test bug-lf-1852 "Don't shuffle master/slave instances unnecessarily"
do_test master-failed-demote "Dont retry failed demote actions"
do_test master-failed-demote-2 "Dont retry failed demote actions (notify=false)"
do_test master-depend "Ensure resources that depend on the master don't get allocated until the master does"
do_test master-reattach "Re-attach to a running master"
do_test master-allow-start "Don't include master score if it would prevent allocation"
do_test master-colocation "Allow master instances placemaker to be influenced by colocation constraints"
do_test master-pseudo "Make sure promote/demote pseudo actions are created correctly"
do_test master-role "Prevent target-role from promoting more than master-max instances"
do_test bug-lf-2358 "Master-Master anti-colocation"
do_test master-promotion-constraint "Mandatory master colocation constraints"
do_test unmanaged-master "Ensure role is preserved for unmanaged resources"
do_test master-unmanaged-monitor "Start the correct monitor operation for unmanaged masters"
do_test master-demote-2 "Demote does not clear past failure"
do_test master-move "Move master based on failure of colocated group"   

echo ""
do_test history-1 "Correctly parse stateful-1 resource state"

echo ""
do_test managed-0 "Managed (reference)"
do_test managed-1 "Not managed - down "
do_test managed-2 "Not managed - up   "

echo ""
do_test interleave-0 "Interleave (reference)"
do_test interleave-1 "coloc - not interleaved"
do_test interleave-2 "coloc - interleaved   "
do_test interleave-3 "coloc - interleaved (2)"
do_test interleave-pseudo-stop "Interleaved clone during stonith"
do_test interleave-stop "Interleaved clone during stop"
do_test interleave-restart "Interleaved clone during dependancy restart"

echo ""
do_test notify-0 "Notify reference"
do_test notify-1 "Notify simple"
do_test notify-2 "Notify simple, confirm"
do_test notify-3 "Notify move, confirm"
do_test novell-239079 "Notification priority"
#do_test notify-2 "Notify - 764"

echo ""
do_test 594 "OSDL #594"
do_test 662 "OSDL #662"
do_test 696 "OSDL #696"
do_test 726 "OSDL #726"
do_test 735 "OSDL #735"
do_test 764 "OSDL #764"
do_test 797 "OSDL #797"
do_test 829 "OSDL #829"
do_test 994 "OSDL #994"
do_test 994-2 "OSDL #994 - with a dependant resource"
do_test 1360 "OSDL #1360 - Clone stickiness"
do_test 1484 "OSDL #1484 - on_fail=stop"
do_test 1494 "OSDL #1494 - Clone stability"
do_test unrunnable-1 "Unrunnable"
do_test stonith-0 "Stonith loop - 1"
do_test stonith-1 "Stonith loop - 2"
do_test stonith-2 "Stonith loop - 3"
do_test stonith-3 "Stonith startup"
do_test bug-1572-1 "Recovery of groups depending on master/slave"
do_test bug-1572-2 "Recovery of groups depending on master/slave when the master is never re-promoted"
do_test bug-1685 "Depends-on-master ordering"
do_test bug-1822 "Dont promote partially active groups"
do_test bug-pm-11 "New resource added to a m/s group"
do_test bug-pm-12 "Recover only the failed portion of a cloned group"
do_test bug-n-387749 "Don't shuffle clone instances"
do_test bug-n-385265 "Don't ignore the failure stickiness of group children - resource_idvscommon should stay stopped"
do_test bug-n-385265-2 "Ensure groups are migrated instead of remaining partially active on the current node"
do_test bug-lf-1920 "Correctly handle probes that find active resources"
do_test bnc-515172 "Location constraint with multiple expressions"
do_test colocate-primitive-with-clone "Optional colocation with a clone"
do_test use-after-free-merge "Use-after-free in native_merge_weights"
do_test bug-lf-2551 "STONITH ordering for stop"
do_test bug-lf-2606 "Stonith implies demote"
do_test bug-lf-2474 "Ensure resource op timeout takes precedence over op_defaults"
do_test bug-suse-707150 "Prevent vm-01 from starting due to colocation/ordering"


echo ""
do_test systemhealth1  "System Health ()               #1"
do_test systemhealth2  "System Health ()               #2"
do_test systemhealth3  "System Health ()               #3"
do_test systemhealthn1 "System Health (None)           #1"
do_test systemhealthn2 "System Health (None)           #2"
do_test systemhealthn3 "System Health (None)           #3"
do_test systemhealthm1 "System Health (Migrate On Red) #1"
do_test systemhealthm2 "System Health (Migrate On Red) #2"
do_test systemhealthm3 "System Health (Migrate On Red) #3"
do_test systemhealtho1 "System Health (Only Green)     #1"
do_test systemhealtho2 "System Health (Only Green)     #2"
do_test systemhealtho3 "System Health (Only Green)     #3"
do_test systemhealthp1 "System Health (Progessive)     #1"
do_test systemhealthp2 "System Health (Progessive)     #2"
do_test systemhealthp3 "System Health (Progessive)     #3"

echo ""
do_test utilization "Placement Strategy - utilization"
do_test minimal     "Placement Strategy - minimal"
do_test balanced    "Placement Strategy - balanced"

echo ""
do_test placement-stickiness "Optimized Placement Strategy - stickiness"
do_test placement-priority   "Optimized Placement Strategy - priority"
do_test placement-location   "Optimized Placement Strategy - location"
do_test placement-capacity   "Optimized Placement Strategy - capacity"

echo ""
do_test utilization-order1 "Utilization Order - Simple"
do_test utilization-order2 "Utilization Order - Complex"
do_test utilization-order3 "Utilization Order - Migrate"
do_test utilization-order4 "Utilization Order - Live Mirgration (bnc#695440)"
do_test utilization-shuffle "Don't displace prmExPostgreSQLDB2 on act2, Start prmExPostgreSQLDB1 on act3"

echo ""
do_test reprobe-target_rc "Ensure correct target_rc for reprobe of inactive resources"

echo ""
do_test stopped-monitor-00	"Stopped Monitor - initial start"
do_test stopped-monitor-01	"Stopped Monitor - failed started"
do_test stopped-monitor-02	"Stopped Monitor - started multi-up"
do_test stopped-monitor-03	"Stopped Monitor - stop started"
do_test stopped-monitor-04	"Stopped Monitor - failed stop"
do_test stopped-monitor-05	"Stopped Monitor - start unmanaged"
do_test stopped-monitor-06	"Stopped Monitor - unmanaged multi-up"
do_test stopped-monitor-07	"Stopped Monitor - start unmanaged multi-up"
do_test stopped-monitor-08	"Stopped Monitor - migrate"
do_test stopped-monitor-09	"Stopped Monitor - unmanage started"
do_test stopped-monitor-10	"Stopped Monitor - unmanaged started multi-up"
do_test stopped-monitor-11	"Stopped Monitor - stop unmanaged started"
do_test stopped-monitor-12	"Stopped Monitor - unmanaged started multi-up (targer-role="Stopped")"
do_test stopped-monitor-20	"Stopped Monitor - initial stop"
do_test stopped-monitor-21	"Stopped Monitor - stopped single-up"
do_test stopped-monitor-22	"Stopped Monitor - stopped multi-up"
do_test stopped-monitor-23	"Stopped Monitor - start stopped"
do_test stopped-monitor-24	"Stopped Monitor - unmanage stopped"
do_test stopped-monitor-25	"Stopped Monitor - unmanaged stopped multi-up"
do_test stopped-monitor-26	"Stopped Monitor - start unmanaged stopped"
do_test stopped-monitor-27	"Stopped Monitor - unmanaged stopped multi-up (target-role="Started")"
do_test stopped-monitor-30	"Stopped Monitor - new node started"
do_test stopped-monitor-31	"Stopped Monitor - new node stopped"

echo""
do_test ticket-primitive-1 "Ticket - Primitive (loss-policy=stop, initial)"
do_test ticket-primitive-2 "Ticket - Primitive (loss-policy=stop, granted)"
do_test ticket-primitive-3 "Ticket - Primitive (loss-policy-stop, revoked)"
do_test ticket-primitive-4 "Ticket - Primitive (loss-policy=demote, initial)"
do_test ticket-primitive-5 "Ticket - Primitive (loss-policy=demote, granted)"
do_test ticket-primitive-6 "Ticket - Primitive (loss-policy=demote, revoked)"
do_test ticket-primitive-7 "Ticket - Primitive (loss-policy=fence, initial)"
do_test ticket-primitive-8 "Ticket - Primitive (loss-policy=fence, granted)"
do_test ticket-primitive-9 "Ticket - Primitive (loss-policy=fence, revoked)"
do_test ticket-primitive-10 "Ticket - Primitive (loss-policy=freeze, initial)"
do_test ticket-primitive-11 "Ticket - Primitive (loss-policy=freeze, granted)"
do_test ticket-primitive-12 "Ticket - Primitive (loss-policy=freeze, revoked)"

echo""
do_test ticket-group-1 "Ticket - Group (loss-policy=stop, initial)"
do_test ticket-group-2 "Ticket - Group (loss-policy=stop, granted)"
do_test ticket-group-3 "Ticket - Group (loss-policy-stop, revoked)"
do_test ticket-group-4 "Ticket - Group (loss-policy=demote, initial)"
do_test ticket-group-5 "Ticket - Group (loss-policy=demote, granted)"
do_test ticket-group-6 "Ticket - Group (loss-policy=demote, revoked)"
do_test ticket-group-7 "Ticket - Group (loss-policy=fence, initial)"
do_test ticket-group-8 "Ticket - Group (loss-policy=fence, granted)"
do_test ticket-group-9 "Ticket - Group (loss-policy=fence, revoked)"
do_test ticket-group-10 "Ticket - Group (loss-policy=freeze, initial)"
do_test ticket-group-11 "Ticket - Group (loss-policy=freeze, granted)"
do_test ticket-group-12 "Ticket - Group (loss-policy=freeze, revoked)"
  
echo""
do_test ticket-clone-1 "Ticket - Clone (loss-policy=stop, initial)"
do_test ticket-clone-2 "Ticket - Clone (loss-policy=stop, granted)"
do_test ticket-clone-3 "Ticket - Clone (loss-policy-stop, revoked)"
do_test ticket-clone-4 "Ticket - Clone (loss-policy=demote, initial)"
do_test ticket-clone-5 "Ticket - Clone (loss-policy=demote, granted)"
do_test ticket-clone-6 "Ticket - Clone (loss-policy=demote, revoked)"
do_test ticket-clone-7 "Ticket - Clone (loss-policy=fence, initial)"
do_test ticket-clone-8 "Ticket - Clone (loss-policy=fence, granted)"
do_test ticket-clone-9 "Ticket - Clone (loss-policy=fence, revoked)"
do_test ticket-clone-10 "Ticket - Clone (loss-policy=freeze, initial)"
do_test ticket-clone-11 "Ticket - Clone (loss-policy=freeze, granted)"
do_test ticket-clone-12 "Ticket - Clone (loss-policy=freeze, revoked)"
  
echo""  
do_test ticket-master-1 "Ticket - Master (loss-policy=stop, initial)"
do_test ticket-master-2 "Ticket - Master (loss-policy=stop, granted)"
do_test ticket-master-3 "Ticket - Master (loss-policy-stop, revoked)"
do_test ticket-master-4 "Ticket - Master (loss-policy=demote, initial)"
do_test ticket-master-5 "Ticket - Master (loss-policy=demote, granted)"
do_test ticket-master-6 "Ticket - Master (loss-policy=demote, revoked)"
do_test ticket-master-7 "Ticket - Master (loss-policy=fence, initial)"
do_test ticket-master-8 "Ticket - Master (loss-policy=fence, granted)"
do_test ticket-master-9 "Ticket - Master (loss-policy=fence, revoked)"
do_test ticket-master-10 "Ticket - Master (loss-policy=freeze, initial)"
do_test ticket-master-11 "Ticket - Master (loss-policy=freeze, granted)"
do_test ticket-master-12 "Ticket - Master (loss-policy=freeze, revoked)"

echo ""
do_test ticket-rsc-sets-1 "Ticket - Resource sets (1 ticket, initial)"
do_test ticket-rsc-sets-2 "Ticket - Resource sets (1 ticket, granted)"
do_test ticket-rsc-sets-3 "Ticket - Resource sets (1 ticket, revoked)"
do_test ticket-rsc-sets-4 "Ticket - Resource sets (2 tickets, initial)"
do_test ticket-rsc-sets-5 "Ticket - Resource sets (2 tickets, granted)"
do_test ticket-rsc-sets-6 "Ticket - Resource sets (2 tickets, granted)"
do_test ticket-rsc-sets-7 "Ticket - Resource sets (2 tickets, revoked)"

echo ""
do_test template-1 "Template - 1"
do_test template-2 "Template - 2"
do_test template-3 "Template - 3 (merge operations)"

do_test template-coloc-1 "Template - Colocation 1"
do_test template-coloc-2 "Template - Colocation 2"
do_test template-coloc-3 "Template - Colocation 3"
do_test template-order-1 "Template - Order 1"
do_test template-order-2 "Template - Order 2"
do_test template-order-3 "Template - Order 3"
do_test template-ticket  "Template - Ticket"

do_test template-rsc-sets-1  "Template - Resource Sets 1"
do_test template-rsc-sets-2  "Template - Resource Sets 2"
do_test template-rsc-sets-3  "Template - Resource Sets 3"
do_test template-rsc-sets-4  "Template - Resource Sets 4"

echo ""

test_results
