require "rails_helper"

RSpec.describe 'The project show page' do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    @contestants = [@jay, @gretchen, @kentaro, @erin]
    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
  end

  describe "as a visitor" do
    describe "visiting show page" do
      it "I see projects name and material" do

        visit "/projects/#{@news_chic.id}"

        expect(page).to have_content(@news_chic.name)
        expect(page).to have_content(@news_chic.material)
      end

      it "I see theme of the challenge this project belongs to" do
        visit "/projects/#{@news_chic.id}"

        expect(page).to have_content(@recycled_material_challenge.theme)
      end

      it 'I see a count of the number of contestants on this project' do
        visit "/projects/#{@news_chic.id}"

        expect(page).to have_content("Contestants on Project: 2")

        visit "/projects/#{@lit_fit.id}"

        expect(page).to have_content("Contestants on Project: 0")

        visit "/projects/#{@boardfit.id}"

        expect(page).to have_content("Contestants on Project: 2")
      end

      it 'has the average years of exp for the contestants on the project' do
        visit "/projects/#{@news_chic.id}"

        expect(page).to have_content("Average Contestant Experience: 12.5")

        visit "/projects/#{@lit_fit.id}"

        expect(page).to have_content("Average Contestant Experience: 0")

        visit "/projects/#{@boardfit.id}"

        expect(page).to have_content("Average Contestant Experience: 11.5")
      end

      it 'has a form to add contestant to this project' do
        visit "/projects/#{@news_chic.id}"

        within "#add_contestant" do
          expect(page).to have_content("Contestant ID")
        end
      end

      describe 'filling out/ submitting form' do
       it 'returns back to project show page with contestants count increase by one' do
          visit "/projects/#{@news_chic.id}"

          within "#add_contestant" do
            fill_in('contestant_id', with: @kentaro.id)
            click_button('Add Contestant')
          end

          expect(page).to have_content("Contestants on Project: 3")
        end

        it 'when I visit the contestants index page, I see that project listed under their name' do
          visit "/projects/#{@news_chic.id}"

          within "#add_contestant" do
            fill_in('contestant_id', with: @kentaro.id)
            click_button('Add Contestant')
          end

          visit "/contestants"

          within "#contestant_#{@kentaro.id}" do
            expect(page).to have_content(@news_chic.name)
          end
        end
      end 
    end
  end
end