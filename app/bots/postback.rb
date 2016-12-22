class Postback
  attr_reader :postback

  def initialize(postback)
    @postback = postback
  end

  def reply
    puts postback.payload
    if postback.payload == 'GET_STARTED'
      postback.reply(get_started_reply)
    elsif postback.payload == 'NEXT_GAME'
      postback.reply(next_game_reply)
    end
  end

  def get_started_reply
      {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'button',
            text: "Ok mon pote, en quoi puis-je t'aider ?",
            buttons: [
              { type: 'postback', title: 'Prochain match', payload: 'NEXT_GAME' }
            ]
          }
        }
      }
  end

  def next_game_reply
    {text: "Ça marche, voilà le deal : tu me donnes un club de L1 et moi je te donne son prochain match ;)"}
  end
end