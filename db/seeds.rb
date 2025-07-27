User.create!(email_address: "contact@peterszarvas.hu", password: "123")

post1 = Post.create!(title: "Welcome", body: "First post")
post1.comments.create!(content: "Great post!")
post1.comments.create!(content: "Hello there!")

post2 = Post.create!(title: "Rails", body: "Learning Rails")
post2.comments.create!(content: "Very helpful")
post2.comments.create!(content: "Thanks a lot")
