cache @posts.first do
  atom_feed do |feed|
    feed.title(@title)
    feed.updated(@posts[0].created_at) if @posts.length > 0

    @posts.each do |post|
      feed.entry(post) do |entry|
        entry.title(post.title)
        entry.content(post.body, :type => 'html')

        entry.author do |author|
          author.name(post.author)
        end
      end
    end
  end
end