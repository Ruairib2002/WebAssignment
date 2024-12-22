require 'graphviz'

graph = GraphViz.new(:G, type: :digraph)
graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')

graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id")
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription", shape: "rect")
graph.add_nodes("UserGroups", label: "UserGroups\nuser_id (FK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nsubmitted_at", shape: "rect")
graph = GraphViz.new(:G, type: :digraph)
graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')

graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
puts "ER Diagram saved to Desktop at #{output_path}"

require 'graphviz'

graph = GraphViz.new(:G, type: :digraph)
graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')

graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id")
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription", shape: "rect")
graph.add_nodes("UserGroups", label: "UserGroups\nuser_id (FK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nsubmitted_at", shape: "rect")
graph.add_nodes("Files", label: "Files\nfile_id (PK)\nfile_name\nuploaded_by (FK)", shape: "rect")
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\ngroup_id (FK)\nuser_id (FK)\ncontent", shape: "rect")
graph.add_nodes("ActiveStorageBlobs", label: "ActiveStorageBlobs\nblob_id (PK)\nfilename", shape: "rect")
graph.add_nodes("ActiveStorageAttachments", label: "ActiveStorageAttachments\nattachment_id (PK)\nblob_id (FK)\nrecord_id", shape: "rect")                                                  12,1          Topgraph.add_nodes("Files", label: "Files\nfile_id (PK)\nfile_name\nuploaded_by (FK)", shape: "rect")
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\ngroup_id (FK)\nuser_id (FK)\ncontent", shape: "rect")
graph.add_nodes("ActiveStorageBlobs", label: "ActiveStorageBlobs\nblob_id (PK)\nfilename", shape: "rect")
graph.add_nodes("ActiveStorageAttachments", label: "ActiveStorageAttachments\nattachment_id (PK)\nblob_id (FK)\nrecord_id", shape: "rect")

graph.add_edges("Users", "Roles", label: "has role", dir: :forward)
graph.add_edges("Groups", "Users", label: "has teacher", dir: :forward)
graph.add_edges("Assignments", "Groups", label: "belongs to", dir: :forward)
graph.add_edges("Files", "Users", label: "uploaded by", dir: :forward)
graph.add_edges("Messages", "Users", label: "posted by", dir: :forward)
graph.add_edges("Messages", "Groups", label: "belongs to", dir: :forward)
graph.add_edges("Submissions", "Users", label: "submitted by", dir: :forward)
graph.add_edges("Submissions", "Assignments", label: "belongs to", dir: :forward)
graph.add_edges("Users", "Groups", label: "member of", dir: :both)
graph.add_edges("UserGroups", "Users", label: "joins", dir: :both)
graph.add_edges("UserGroups", "Groups", label: "part of", dir: :both)

output_path = File.expand_path("~/Desktop/Assignment_ER_Diagram.png")
graph.output(png: output_path)

puts "ER Diagram saved to Desktop at #{output_path}"
graph.add_nodes("ActiveStorageBlobs", label: "ActiveStorageBlobs\nblob_id (PK)\nfilename", shape: "rect")
graph.add_nodes("ActiveStorageAttachments", label: "ActiveStorageAttachments\nattachment_id (PK)\nblob_id (FK)\nrecord_id", shape: "rect")

graph.add_edges("Users", "Roles", label: "has role", dir: :forward)
graph.add_edges("Groups", "Users", label: "has teacher", dir: :forward)
graph.add_edges("Assignments", "Groups", label: "belongs to", dir: :forward)
graph.add_edges("Files", "Users", label: "uploaded by", dir: :forward)
graph.add_edges("Messages", "Users", label: "posted by", dir: :forward)
graph.add_edges("Messages", "Groups", label: "belongs to", dir: :forward)
graph.add_edges("Submissions", "Users", label: "submitted by", dir: :forward)
graph.add_edges("Submissions", "Assignments", label: "belongs to", 
graph.add_edges("Users", "Roles", label: "has role", dir: :forward)
graph.add_edges("Groups", "Users", label: "has teacher", dir: :forward)
graph.add_edges("Assignments", "Groups", label: "belongs to", dir: :forward)
graph.add_edges("Files", "Users", label: "uploaded by", dir: :forward)
graph.add_edges("Messages", "Users", label: "posted by", dir: :forward)
graph.add_edges("Messages", "Groups", label: "belongs to", dir: :forward)
graph.add_edges("Users", "Groups", label: "member of", dir: :both)


output_path = File.expand_path("~/Desktop/Assignment_ER_Diagram.png")
➜  WebAssignment git:(main) ✗ vim web_er.rb

➜  WebAssignment git:(main) ✗ ruby web_er.rb

web_er.rb: --> web_er.rb
syntax error, unexpected unary-, expecting `do' or '{' or '('
>  1  require 'graphviz'
>  3  graph = GraphViz.new(:G, type: :digraph)
>  4  graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')
>  6  graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id")
>  7  graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
>  8  graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription", shape: "rect")
>  9  graph.add_nodes("UserGroups", label: "UserGroups\nuser_id (FK)\ngroup_id (FK)", shape: "rect")
> 10  graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)", shape: "rect")
> 11  graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nsubmitted_at", shape: "rect")
> 12  graph = GraphViz.new(:G, type: :digraph)
> 13  graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')
> 15  graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
> 16  puts "ER Diagram saved to Desktop at #{output_path}"
> 18  require 'graphviz'
> 20  graph = GraphViz.new(:G, type: :digraph)
> 21  graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')
> 23  graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id")
> 24  graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
> 25  graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription", shape: "rect")
require 'graphviz'

graph = GraphViz.new(:G, type: :digraph)
graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')

graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id")
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription", shape: "rect")
graph.add_nodes("UserGroups", label: "UserGroups\nuser_id (FK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nsubmitted_at", shape: "rect")
graph = GraphViz.new(:G, type: :digraph)
graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')

graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
puts "ER Diagram saved to Desktop at #{output_path}"

require 'graphviz'

