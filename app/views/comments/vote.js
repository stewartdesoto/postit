<% if @vote.valid? %>
  $('#comment_vote_<%= @comment.id %>').
      html('<%= @comment.net_votes %> votes');
<% else %>
  alert('You can only vote once, like i told you before')
<% end %>