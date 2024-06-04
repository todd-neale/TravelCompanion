class DrinkingWaterController < ApplicationController

  def location
    @location = [{lat: "51.5074456", lon: "-0.1277653"}]
  end

  def process_location
    location = params[:location]
    # @location = [{lat: Geocoder.search(location).data['lat'], lon: Geocoder.search(location).data['lat']}]

    client = OpenAI::Client.new
    chaptgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "Firstly find the location by the coordinates provided. Then tell me in one sentence is the tap water safe to drink in #{location}. Answer like: 'Yes the water is safe to drink', 'No, however there are some reports of the water is okay' 'No, the water is not safe to drink'"}]
    })

    if true # chatgpt_response
      @content = "Yes you can drink the water" # chaptgpt_response["choices"][0]["message"]["content"]
      render turbo_stream: turbo_stream.replace("response", partial: "drinking_water/partials/response")
    else
      flash[:error] = "Error processing this location"
    end
  end
end
