  UW PICO 5.09                           New Buffer





















                               [ Read 33 lines ]
^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spell
  UW PICO 5.09                   File: create_er_diagram.rb

require 'graphviz'

# Create a new Graphviz object
graph = GraphViz.new(:G, type: :digraph)

# Define nodes (tables)
graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id$
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\ngroup_name\nteacher_id$
graph.add_nodes("UserGroups", label: "User_Groups\nuser_id (FK)\ngroup_id (FK)")
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\ngroup_id (FK)\np$
graph.add_nodes("Files", label: "Files\nfile_id (PK)\ngroup_id (FK)\nuploaded_b$
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_i$
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignm$

# Define edges (relationships)
graph.add_edges("Users", "Roles", label: "has", dir: :forward)
graph.add_edges("Users", "UserGroups", label: "joins", dir: :forward)
graph.add_edges("Groups", "UserGroups", label: "has members", dir: :both)  # Ma$
graph.add_edges("Groups", "Messages", label: "contains", dir: :forward)

^G Get Help  ^O WriteOut  ^R Read File ^Y Prev Pg   ^K Cut Text  ^C Cur Pos
^X Exit      ^J Justify   ^W Where is  ^V Next Pg   ^U UnCut Text^T To Spellrequire 'graphviz'

# Create a new Graphviz object
graph = GraphViz.new(:G, type: :digraph)

# Define nodes (tables)
graph.add_nodes("Users", label: "Users\nuser_id (PK)\nfull_name\nemail\nrole_id (FK)")
graph.add_nodes("Roles", label: "Roles\nrole_id (PK)\nrole_name")
graph.add_nodes("Groups", label: "Groups\ngroup_id (PK)\ngroup_name\nteacher_id (FK)")
graph.add_nodes("UserGroups", label: "User_Groups\nuser_id (FK)\ngroup_id (FK)")
graph.add_nodes("Messages", label: "Messages\nmessage_id (PK)\ngroup_id (FK)\nposted_by (FK)\nmessage_content")
graph.add_nodes("Files", label: "Files\nfile_id (PK)\ngroup_id (FK)\nuploaded_by (FK)\nfile_name\nfile_path")
graph.add_nodes("Assignments", label: "Assignments\nassignment_id (PK)\ngroup_id (FK)\ntitle\ndescription\ndue_date")
graph.add_nodes("Submissions", label: "Submissions\nsubmission_id (PK)\nassignment_id (FK)\nuser_id (FK)\nmarks")

# Define edges (relationships)
graph.add_edges("Users", "Roles", label: "has", dir: :forward)
graph.add_edges("Users", "UserGroups", label: "joins", dir: :forward)
graph.add_edges("Groups", "UserGroups", label: "has members", dir: :both)  # Many-to-many relationship
graph.add_edges("Groups", "Messages", label: "contains", dir: :forward)
graph.add_edges("Users", "Messages", label: "posts", dir: :forward)
graph.add_edges("Groups", "Files", label: "has files", dir: :forward)
graph.add_edges("Users", "Files", label: "uploads", dir: :forward)
graph.add_edges("Groups", "Assignments", label: "includes", dir: :forward)
graph.add_edges("Assignments", "Submissions", label: "has submissions", dir: :forward)
graph.add_edges("Users", "Submissions", label: "submits", dir: :forward)

# Render the diagram as a PNG image and save it to the Desktop
output_path = File.expand_path("~/Desktop/ER_Diagram.png")
graph.output(png: output_path)

puts "ER Diagram saved to Desktop at #{output_path}"

