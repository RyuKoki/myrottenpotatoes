require 'rails_helper'



describe MoviesController do
  
  describe 'searching TMDb' do
    before :each do 
      allow(controller).to receive(:require_login) #controller to mock login
    end 
    it 'should call the model method that performs TMDb search' do 
        expect(Movie).to receive(:find_in_tmdb).with('hardware').  #movie response with find in tmdb w/ hardware
            and_return(@fake_results)                   #get result 
        post :search_tmdb, params: {:search_tmdb => 'hardware'} 
    end 
    describe 'after valid search' do
        before :each do
          #search in each test
          allow(Movie).to receive(:find_in_tmdb).and_return(@fake_results)
          post :search_tmdb, params: {:search_tmdb => 'hardware'}
        end
        it 'selects the Search Results template for rendering' do
          #was rendering 'tmdb' template
          expect(response).to render_template('tmdb')
        end
        it 'makes the TMDb search results available to that template' do
          expect(assigns(:movies)).to eq(@fake_results)
        end

        it 'assign to save into RottenTomatoes database' do
            post :create_from_tmdb , params: {:tmdb_id => '739990'}
            expect(assigns(:movies)).to eq(@fake_results)
        end
    end

    describe 'after imvalid search' do
      before :each do
        allow(controller).to receive(:require_login) #allow to login first 
        allow(Movie).to receive(:find_in_tmdb).and_return(@fake_results) #Movies respond to find_in_tmdb 
        @blank_keyword = ''
        post :search_tmdb, params: {:search_tmdb => @blank_keyword} #search w/ blank keywword
      end
      it 'flashing error and come to home page' do
        expect(flash[:warning]).to match(/You cannot blank*/) #test for flash error 
        expect(response).to redirect_to(movies_path)  #test for redirect to movie page 
      end
     end
  end
  

  describe 'add movie' do

    describe 'With login ' do

      before :each do
        allow(controller).to receive(:require_login) #allow tester to loggin 
        @mock_movie_attributes = {movie:{:title => 'Space Balls', :release_date => '24/6/1987', :rating => 'PG', :description => "testing"}} #mock up parameter 
        @mock_movie_empty = {movie:{:title => nil , :release_date => '24/6/1987', :rating => 'PG', :description => "testing"}} #mock up none tilel
      end

      it 'Add movie to and save' do
        expect{post :create, params: @mock_movie_attributes}.to change(Movie,:count).by(1) #check if database was increaseing 
      end
      
      it "assigns the saved movie to @movie" do
        post :create, params: @mock_movie_attributes #create to db 
        expect(assigns(:movie).title).to include("Space Balls") #test for in db already 
      end

      it "redirects to the home page" do
        post :create, params: @mock_movie_attributes  #creat to db
        expect(response).to redirect_to(new_movie_review_path(movie_id:Movie.all.length)) #is that redirect to add review by it own review movie
      end

      describe 'edit' do
        before :each do
          
          @fact_movie = FactoryGirl.create(:movie)
        end
    
        it "edit movie" do
          get :edit, params: {id: @fact_movie.id}     
          expect(assigns(:movie).title)==("new")
        end
    
        it "redirects to the movie page" do
          post :show, params: {id: @fact_movie.id}    
          expect(response).to render_template('show')
        end
        
      end
  

    end
    
    describe "Without Login" do 
      it "Go to Movies path/Homepage" do
        post :create 
        expect(response).to redirect_to(movies_path)
      end 
    end
  end 
  
end