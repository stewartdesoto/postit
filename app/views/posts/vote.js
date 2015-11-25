<% if @vote.valid? %>
  <%= puts "have @vote.valid? in posts/vote.js" %>
  $('#post_<%=@post.slug%>_votes').html('<%= @post.net_votes %> votes')
<% else %>
  <%= puts "errors with @vote in posts/vote.js" %>
  <%= puts @vote.errors.full_messages %>
  alert('You can vote once.')
<% end %>