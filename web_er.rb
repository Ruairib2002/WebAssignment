require 'graphviz'

graph = GraphViz.new(:G, type: :digraph, rankdir: 'LR', nodesep: '1', ranksep: '2')

graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id (FK)\nbio\nprofile_picture (FK to ActiveStorageAttachments)", shape: 'record')
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: 'record')
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\ngroup_name\ndescription", shape: 'record')
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)\ntitle\ndescription", shape: 'record')
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nuser_id (FK)\nmarks", shape: 'record')
graph.add_nodes("Files", label: "Files\nfile_id (PK)\nfile_name\nuploaded_by (FK)\nfile_path", shape: 'record')
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\nmessage_content\nposted_by\ngroup_id (FK)\nrecipient_id", shape: 'record')
graph.add_nodes("StudentGroups", label: "Student_Groups\nstudent_id (FK)\ngroup_id (FK)", shape: 'record')
graph.add_nodes("UserGroups", label: "User_Groups\nuser_id (FK)\ngroup_id (FK)", shape: 'record')
graph.add_nodes("ActiveStorageAttachments", label: "ActiveStorageAttachments\nattachment_id (PK)\nrecord_type\nrecord_id\nblob_id (FK)", shape: 'record')
graph.add_nodes("ActiveStorageBlobs", label: "ActiveStorageBlobs\nblob_id (PK)\nfilename\nchecksum", shape: 'record')
graph.add_nodes("ActiveStorageVariantRecords", label: "ActiveStorageVariantRecords\nvariant_record_id (PK)\nblob_id (FK)\nvariation_digest", shape: 'record')

graph.add_edges("Users", "Roles", label: "has role", dir: 'forward')
graph.add_edges("Assignments", "Groups", label: "belongs to group", dir: 'forward')
graph.add_edges("Submissions", "Assignments", label: "belongs to", dir: 'forward')
graph.add_edges("Submissions", "Users", label: "submitted by", dir: 'forward')
graph.add_edges("Files", "Users", label: "uploaded by", dir: 'forward')
graph.add_edges("Messages", "Users", label: "posted by", dir: 'forward')
graph.add_edges("Messages", "Groups", label: "belongs to", dir: 'forward')
graph.add_edges("Messages", "Users", label: "sent to", dir: "both")
graph.add_edges("StudentGroups", "Users", label: "student in", dir: "both")
graph.add_edges("StudentGroups", "Groups", label: "group member", dir: "both")
graph.add_edges("UserGroups", "Users", label: "user in", dir: "both")
graph.add_edges("UserGroups", "Groups", label: "group member", dir: "both")

graph.add_edges("ActiveStorageAttachments", "ActiveStorageBlobs", label: "attached to", dir: "forward")
graph.add_edges("ActiveStorageVariantRecords", "ActiveStorageBlobs", label: "variant of", dir: "forward")
graph.add_edges("Users", "ActiveStorageAttachments", label: "has profile_picture", dir: "forward")

graph.add_edges("Users:user_id", "Roles:role_id", label: "user has role")
graph.add_edges("Users:profile_picture", "ActiveStorageAttachments:record_id", label: "has profile_picture")

output_path = File.expand_path("~/Desktop/Assignment_ER_Diagram.png")
graph.output(png: output_path)

puts "ER Diagram saved to Desktop at #{output_path}"
