class HomeController < ApplicationController
  require 'restclient'  #httparty와 비슷
  def keyboard
    @keyboard = {
    type: "buttons",
    buttons: ["로또", "점심메뉴", "고양이"]
    }
    render json: @keyboard
    
  end
  
  def message
    @user_msg = params[:content] #사용자가 누른 버튼의 내용
    @return_msg = "기본대답"
    
    @url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"

    
    if @user_msg == "로또"
      @return_msg = (1..45).to_a.sample(6).sort.to_s #배열을 스트링으로 바꿔야 해, 제이선이라서..
    elsif @user_msg == "점심메뉴"
      @return_msg = ["20층", "순시", "햄버거", "편도"].sample
    elsif @user_msg == "고양이"
      @cat_xml = RestClient.get(@url)
      @cat_doc = Nokogiri::XML(@cat_xml)
      @cat_url = @cat_doc.xpath("//url").text
      
    end
    
    @basic_keyboard = {
    type: "buttons",
    buttons: ["로또", "점심메뉴", "고양이"]
    }
    
    @basic_msg = {
      text: @return_msg
      
    }
    
    @photo_msg = {
      :text =>"냐옹옹옹",
      :photo => {
        :url => @cat_url,
        :width => 250,
        :height => 250
      }
      
    }
    
    if @user_msg == "고양이" 
      @result = {
        :message => @photo_msg,
        :keyboard => @basic_keyboard
      }
    else

      
      @result = {
        message: @basic_msg,
        keyboard: @basic_keyboard #해쉬 안에 해쉬, 걱정하지마~
        
      }
    end
    
    render json: @result
  end
end

