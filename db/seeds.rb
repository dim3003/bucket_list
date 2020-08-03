admin = User.create! email: 'neill@extensionschool.ch',
                     password: 'password',
                     name: 'NJ Pearman',
                     role: 'admin'


user1 = User.create! email: 'visitor@extensionschool.ch',
                     password: 'password',
                     name: 'Visitor 1'

user2 = User.create! email: 'visitor2@extensionschool.ch',
                     password: 'password',
                     name: 'Visitor 2'

user3 = User.create! email: 'visitor3@extensionschool.ch',
                     password: 'password',
                     name: 'Visitor 3'

1.upto(5) do |i|
  Idea.create! title: "Idea for #{admin.name} #{i}", user: admin
  Idea.create! title: "Idea for #{user1.name} #{i}", user: user1
  Idea.create! title: "Idea for #{user2.name} #{i}", user: user2
  Idea.create! title: "Idea for #{user3.name} #{i}", user: user3
end

admin.goals << user1.ideas.first
admin.goals << user2.ideas.first
admin.goals << user3.ideas.first
