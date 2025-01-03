require 'graphviz'

# Create a new directed graph (digraph) and apply graph-level attributes
graph = GraphViz.new(:G, type: :digraph, rankdir: 'LR', nodesep: '1', ranksep: '2')

# Add nodes (tables) to the graph, specifying primary keys (PK) and foreign keys (FK)
graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id (FK)")
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\ngroup_name\ndescription")
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)\ntitle\ndescription")
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nuser_id (FK)\nmarks")
graph.add_nodes("Files", label: "Files\nfile_id (PK)\nfile_name\nuploaded_by (FK)\nfile_path")
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\nmessage_content\nposted_by\ngroup_id (FK)\nrecipient_id")
graph.add_nodes("StudentGroups", label: "Student_Groups\nstudent_id (FK)\ngroup_id (FK)")
graph.add_nodes("UserGroups", label: "User_Groups\nuser_id (FK)\ngroup_id (FK)")
graph.add_nodes("ActiveStorageAttachments", label: "ActiveStorageAttachments\nattachment_id (PK)\nrecord_type\nrecord_id\nblob_id (FK)")
graph.add_nodes("ActiveStorageBlobs", label: "ActiveStorageBlobs\nblob_id (PK)\nfilename\nchecksum")
graph.add_nodes("ActiveStorageVariantRecords", label: "ActiveStorageVariantRecords\nvariant_record_id (PK)\nblob_id (FK)\nvariation_digest")

# Add edges (relationships) between the fields (not just the tables)
graph.add_edges("Users", "Roles", label: "has role")
graph.add_edges("Assignments", "Groups", label: "belongs to group")
graph.add_edges("Submissions", "Assignments", label: "belongs to", fromport: "assignment_id", toport: "assignment_id")
graph.add_edges("Submissions", "Users", label: "submitted by", fromport: "user_id", toport: "user_id")
graph.add_edges("Files", "Users", label: "uploaded by", fromport: "uploaded_by", toport: "user_id")
graph.add_edges("Messages", "Users", label: "posted by", fromport: "posted_by", toport: "user_id")
graph.add_edges("Messages", "Groups", label: "belongs to", fromport: "group_id", toport: "group_id")
graph.add_edges("Messages", "Users", label: "sent to", dir: "both", fromport: "recipient_id", toport: "user_id")
graph.add_edges("StudentGroups", "Users", label: "student in", dir: "both", fromport: "student_id", toport: "user_id")
graph.add_edges("StudentGroups", "Groups", label: "group member", dir: "both", fromport: "group_id", toport: "group_id")
graph.add_edges("UserGroups", "Users", label: "user in", dir: "both", fromport: "user_id", toport: "user_id")
graph.add_edges("UserGroups", "Groups", label: "group member", dir: "both", fromport: "group_id", toport: "group_id")

# ActiveStorage relationships (using blobs and attachments)
graph.add_edges("ActiveStorageAttachments", "ActiveStorageBlobs", label: "attached to", fromport: "blob_id", toport: "blob_id")
graph.add_edges("ActiveStorageVariantRecords", "ActiveStorageBlobs", label: "variant of", fromport: "blob_id", toport: "blob_id")

# Define the output path and save the diagram as a PNG file
output_path = File.expand_path("~/Desktop/Assignment_ER_Diagram.png")
graph.output(png: output_path)

puts "ER Diagram saved to Desktop at #{output_path}"
