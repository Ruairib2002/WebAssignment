require 'graphviz'

# Create a new directed graph
graph = GraphViz.new(:G, type: :digraph)

# Add nodes (entities) with specific fields
graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id (FK)")
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription\nteacher_id (FK)", shape: "rect")
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ntitle\ndescription\ndue_date\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nmarks\nassignment_id (FK)\nuser_id (FK)", shape: "rect")
graph.add_nodes("Files", label: "Files\nfile_id (PK)\nfile_name\nuploaded_by (FK)\nuploaded_at", shape: "rect")
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\nmessage_content\nposted_by (FK)\ngroup_id (FK)\nrecipient_id (FK)", shape: "rect")
graph.add_nodes("UserGroups", label: "UserGroups\nuser_id (FK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("ActiveStorageBlobs", label: "ActiveStorageBlobs\nblob_id (PK)\nkey\nfilename\nservice_name", shape: "rect")
graph.add_nodes("ActiveStorageAttachments", label: "ActiveStorageAttachments\nattachment_id (PK)\nblob_id (FK)\nrecord_id (FK)", shape: "rect")

# Add relationships (edges) between specific fields
graph.add_edges("Users", "Roles", label: "role_id (FK)")
graph.add_edges("UserGroups", "Users", label: "user_id (FK)")
graph.add_edges("UserGroups", "Groups", label: "group_id (FK)")
graph.add_edges("Groups", "Assignments", label: "group_id (FK)")
graph.add_edges("Assignments", "Submissions", label: "assignment_id (FK)")
graph.add_edges("Users", "Submissions", label: "user_id (FK)")
graph.add_edges("Users", "Files", label: "uploaded_by (FK)")
graph.add_edges("Groups", "Messages", label: "group_id (FK)")
graph.add_edges("Users", "Messages", label: "posted_by (FK)")
graph.add_edges("Users", "Messages", label: "recipient_id (FK)")
graph.add_edges("ActiveStorageAttachments", "ActiveStorageBlobs", label: "blob_id (FK)")

# Output the diagram to a file
output_path = "#{Dir.home}/Desktop/er_diagram.png"
graph.output(png: output_path)

puts "ER Diagram saved to Desktop at #{output_path}"








