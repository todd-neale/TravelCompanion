class DrinkingWaterController < ApplicationController
  def location
    @markers = [{lat: "51.5074456", lon: "-0.1277653"}]
  end

  def process_location
    location = params[:location]
    geocoded_location = Geocoder.search(location).first
    @markers = [{ lat: geocoded_location.data['lat'], lon: geocoded_location.data['lon'] }]

    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: " Then tell me in one sentence is the tap water safe to drink in #{location}. Please answer the drinking waters safety first followed by the name of the location. Answer like: 'Yes the water is safe to drink', 'No, however there are some reports of the water is okay' 'No, the water is not safe to drink'"}]
    })

    if chatgpt_response
      @content = chatgpt_response["choices"][0]["message"]["content"]
      render turbo_stream: turbo_stream.replace("response", partial: "drinking_water/partials/response")
    else
      flash[:error] = "Error processing this location"
    end
  end
end
