require 'rails_helper'

describe MoviesController do
  describe 'searching TMDb' do
    it 'should call the model method that performs TMDb search' do 
        expect(Movie).to receive(:find_in_tmdb).with('hardware').
            and_return(@fake_results)
        post :search_tmdb, params: {:search_tmdb => 'hardware'}
    end 
    describe 'after valid search' do
        before :each do
          allow(Movie).to receive(:find_in_tmdb).and_return(@fake_results)
          post :search_tmdb, params: {:search_tmdb => 'hardware'}
        end
        it 'selects the Search Results template for rendering' do
          expect(response).to render_template('tmdb')
        end
        it 'makes the TMDb search results available to that template' do
          expect(assigns(:movies)).to eq(@fake_results)
        end
    end
  end

end