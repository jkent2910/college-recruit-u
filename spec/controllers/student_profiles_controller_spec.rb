require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe StudentProfilesController, type: :controller do
  include Devise::TestHelpers

  before do
    @sarah = FactoryGirl.create(:sarah)
    sign_in @sarah
  end

  # This should return the minimal set of attributes required to create a valid
  # StudentProfile. As you add validations to StudentProfile, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      first_name: "Sarah",
      last_name: "Smith",
      gender: "Female",
      high_school: "Valley High School",
      graduation_year: "2016",
      user_id: @sarah.to_param
    }
  }

  let(:invalid_attributes) {
    {
      first_name: nil,
      last_name: nil,
      gender: nil,
      high_school: nil,
      graduation_year: nil
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StudentProfilesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  context "student's own profile" do
    describe "GET #index" do
      it "assigns all student_profiles as @student_profiles" do
        student_profile = StudentProfile.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:student_profiles)).to eq([student_profile])
      end

      it "excludes incognito student profiles" do
        student_profile = FactoryGirl.create(:student_profile)
        incognito_profile = FactoryGirl.create(:student_profile, incognito: true)
        get :index, {}, valid_session
        expect(assigns(:student_profiles)).to eq([student_profile])
      end

      it "does not allow users without a student profile to view the index" do 
        get :index
        expect(flash[:notice]).to match("create a student profile first")
      end
    end

    describe "GET #show" do
      it "assigns the requested student_profile as @student_profile" do
        student_profile = StudentProfile.create! valid_attributes
        get :show, {:id => student_profile.to_param}, valid_session
        expect(assigns(:student_profile)).to eq(student_profile)
      end
    end

    describe "GET #new" do
      context "when user has no StudentProfile" do
        it "assigns a new student_profile as @student_profile" do
          get :new, {}, valid_session
          expect(assigns(:student_profile)).to be_a_new(StudentProfile)
        end
      end

      context "when user already has a StudentProfile" do
        before do
          @student_profile = FactoryGirl.create(:student_profile, student: @sarah)
          get :new, {}, valid_session
        end

        it "redirects to the StudentProfile show page" do
          expect(response).to redirect_to(@student_profile)
        end

        it "displays an appropriate message" do
          expect(flash[:notice]).to match("already created")
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested student_profile as @student_profile" do
        student_profile = StudentProfile.create! valid_attributes
        get :edit, {:id => student_profile.to_param}, valid_session
        expect(assigns(:student_profile)).to eq(student_profile)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new StudentProfile" do
          expect {
            post :create, {:student_profile => valid_attributes}, valid_session
          }.to change(StudentProfile, :count).by(1)
        end

        it "assigns a newly created student_profile as @student_profile" do
          post :create, {:student_profile => valid_attributes}, valid_session
          expect(assigns(:student_profile)).to be_a(StudentProfile)
          expect(assigns(:student_profile)).to be_persisted
        end

        it "redirects to the created student_profile" do
          post :create, {:student_profile => valid_attributes}, valid_session
          expect(response).to redirect_to(StudentProfile.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved student_profile as @student_profile" do
          post :create, {:student_profile => invalid_attributes}, valid_session
          expect(assigns(:student_profile)).to be_a_new(StudentProfile)
        end

        it "re-renders the 'new' template" do
          post :create, {:student_profile => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            first_name: "Sarah",
            last_name: "Smith",
            gender: "Female",
            high_school: "Ankeny Centennial High School",
            graduation_year: "2016"
          }
        }

        it "updates the requested student_profile" do
          student_profile = StudentProfile.create! valid_attributes
          put :update, {:id => student_profile.to_param, :student_profile => new_attributes}, valid_session
          student_profile.reload
          expect(student_profile.high_school).to eq("Ankeny Centennial High School")
        end

        it "assigns the requested student_profile as @student_profile" do
          student_profile = StudentProfile.create! valid_attributes
          put :update, {:id => student_profile.to_param, :student_profile => valid_attributes}, valid_session
          expect(assigns(:student_profile)).to eq(student_profile)
        end

        it "redirects to the student_profile" do
          student_profile = StudentProfile.create! valid_attributes
          put :update, {:id => student_profile.to_param, :student_profile => valid_attributes}, valid_session
          expect(response).to redirect_to(student_profile)
        end
      end

      context "with invalid params" do
        it "assigns the student_profile as @student_profile" do
          student_profile = StudentProfile.create! valid_attributes
          put :update, {:id => student_profile.to_param, :student_profile => invalid_attributes}, valid_session
          expect(assigns(:student_profile)).to eq(student_profile)
        end

        it "re-renders the 'edit' template" do
          student_profile = StudentProfile.create! valid_attributes
          put :update, {:id => student_profile.to_param, :student_profile => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end

      context "interests and majors" do
        before do
          @student_profile = FactoryGirl.create(:student_profile, student: @sarah, interests: ['Marching Band', "Choir"], majors: ["Art", "Biology"])
        end

        let(:attributes_without_interests_or_majors) {
          {
            graduation_year: "2017",
            interests: [],
            majors: []
          }
        }

        it "clears existing interests and majors when no check boxes are checked" do
          put :update, {:id => @student_profile.to_param, :student_profile => attributes_without_interests_or_majors}, valid_session
          @student_profile.reload
          expect(@student_profile.graduation_year).to eq("2017")
          expect(@student_profile.interests).to be_empty
          expect(@student_profile.majors).to be_empty
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested student_profile" do
        student_profile = StudentProfile.create! valid_attributes
        expect {
          delete :destroy, {:id => student_profile.to_param}, valid_session
        }.to change(StudentProfile, :count).by(-1)
      end

      it "redirects to the student_profiles list" do
        student_profile = StudentProfile.create! valid_attributes
        delete :destroy, {:id => student_profile.to_param}, valid_session
        expect(response).to redirect_to(colleges_path)
      end
    end
  end

  context "another student's profile" do
    before do
      other_student = FactoryGirl.create(:user)
      @student_profile = FactoryGirl.create(:student_profile, student: other_student)
    end

    describe "GET #show" do
      it "assigns the requested student_profile as @student_profile" do
        get :show, {:id => @student_profile.to_param}, valid_session
        expect(assigns(:student_profile)).to eq(@student_profile)
      end
    end

    describe "GET #edit" do
      it "redirects to the student profiles list" do
        get :edit, {:id => @student_profile.to_param}, valid_session
        expect(response).to redirect_to(student_profiles_url)
      end

      it "displays an appropriate message" do
        get :edit, {:id => @student_profile.to_param}, valid_session
        expect(flash[:notice]).to match("not allowed")
      end
    end

    describe "PUT #update" do
      it "redirects to the student profiles list" do
        put :update, {:id => @student_profile.to_param, :student_profile => {first_name: "David"}}, valid_session
        expect(response).to redirect_to(student_profiles_url)
      end

      it "displays an appropriate message" do
        put :update, {:id => @student_profile.to_param, :student_profile => {first_name: "David"}}, valid_session
        expect(flash[:notice]).to match("not allowed")
      end
    end

    describe "DELETE #destroy" do
      it "does not delete the student profile" do
        expect {
          delete :destroy, {:id => @student_profile.to_param}, valid_session
        }.not_to change(StudentProfile, :count)
      end

      it "redirects to the student profiles list" do
        delete :destroy, {:id => @student_profile.to_param}, valid_session
        expect(response).to redirect_to(student_profiles_url)
      end

      it "displays an appropriate message" do
        delete :destroy, {:id => @student_profile.to_param}, valid_session
        expect(flash[:notice]).to match("not allowed")
      end
    end
  end

end
