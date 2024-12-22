require 'graphviz'

# Initialize a new directed graph
graph = GraphViz.new(:G, type: :digraph)

# Set some attributes for the graph
graph[:rankdir] = 'LR'  # Horizontal layout
graph[:nodesep] = 1
graph[:ranksep] = 2

# Define the nodes (tables)
graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id (FK)", shape: "rect")
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
graph.add_nodes("Gr:oups", label: "Groups\ngroup_id (PK)\nname\ndescription\nteacher_id", shape: "re




















require 'graphviz'

# Initialize a new directed graph
graph = GraphViz.new(:G, type: :digraph)

# Set some attributes for the graph
graph[:rankdir] = 'LR'  # Horizontal layout
graph[:nodesep] = 1
graph[:ranksep] = 2

# Define the nodes (tables)
graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id (FK)", shape: "rect")
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription\nteacher_id", shape: "regraph.add_nodes("UserGroups", label: "UserGroups\nuser_id (FK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)\ntitle\ndue_date", shape: "rect")
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nuser_id (FK)\nmarks", shape: "rect")
graph.add_nodes("Files", label: "Files\nfile_id (PK)\nfile_name\nuploaded_by (FK)", shape: "rect")
@@@
-- INSERT --                                                  14,100        Topgraph.add_nodes("UserGroups", label: "UserGroups\nuser_id (FK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)\ntitle\ndue_date", shape: "rect")
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nuser_id (FK)\nmarks", shape: "rect")
graph.add_nodes("Files", label: "Files\nfile_id (PK)\nfile_name\nuploaded_by (FK)", shape: "rect")
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\ngroup_id (FK)\nposted_by (FK)\ncontent", shape: "rect")

# Add edges (relationships between tables)
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

# Output the graph to a file
output_path = File.expand_path("~/Desktop/Assignment_ER_Diagram.png")
graph.output(png: output_path)

puts "ER Diagram saved to Desktop at #{output_path}"





















                               [ Read 34 lines ]
^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spell  UW PICO 5.09                           New Buffer





















                               [ Read 34 lines ]
^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spell
  UW PICO 5.09             File: assignment_er_diagram.rb             Modified





                               [ Read 34 lines ]
^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spell
  UW PICO 5.09                 File: assignment_er_diagram.rb

require 'graphviz'

# Initialize a new directed graph
graph = GraphViz.new(:G, type: :digraph)

# Set some attributes for the graph
graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')

graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id$
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription\ntea$

^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spell
  UW PICO 5.09                 File: assignment_er_diagram.rb

require 'graphviz'

# Initialize a new directed graph
graph = GraphViz.new(:G, type: :digraph)

# Set some attributes for the graph
graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')

graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id$
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription\ntea$
graph.add_nodes("UserGroups", label: "UserGroups\nuser_id (FK)\ngroup_id (FK)",$
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_i$
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignm$
graph.add_nodes("Files", label: "Files\nfile_id (PK)\nfile_name\nuploaded_by (F$
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\ngroup_id (FK)\np$


graph.add_edges("Users", "Roles", label: "has role", dir: :forward)
graph.add_edges("Groups", "Users", label: "has teacher", dir: :forward)

^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spellrequire 'graphviz'

# Initialize a new directed graph
graph = GraphViz.new(:G, type: :digraph)

# Set some attributes for the graph
graph.attr('rankdir' => 'LR', 'nodesep' => '1', 'ranksep' => '2')
 
graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id (FK)", shape: "rect")
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name", shape: "rect")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\nname\ndescription\nteacher_id", shape: "rect")
graph.add_nodes("UserGroups", label: "UserGroups\nuser_id (FK)\ngroup_id (FK)", shape: "rect")
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)\ntitle\ndue_date", shape: "rect")
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nuser_id (FK)\nmarks", shape: "rect")
graph.add_nodes("Files", label: "Files\nfile_id (PK)\nfile_name\nuploaded_by (FK)", shape: "rect")
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\ngroup_id (FK)\nposted_by (FK)\ncontent", shape: "rect")


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
