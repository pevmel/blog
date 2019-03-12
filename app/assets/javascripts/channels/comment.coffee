App.comment = App.cable.subscriptions.create "CommentChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#comments_#{data.com_model_name}_#{data.com_model_id}").prepend data.mod_comment
    # Called when there's incoming data on the websocket for this channel
