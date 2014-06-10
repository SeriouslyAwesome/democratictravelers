require 'spec_helper'

describe PostsController do
  shared_examples('public access to posts:') do
    describe 'GET #index' do
      it 'does not require authentication' do
        get :index
        expect(response).to be_success
      end

      it 'finds only published posts' do
        3.times { create(:post) }
        create(:post, published_at: DateTime.now + 1.month)

        get :index
        assigns(:posts).count.should eq(3)
      end

      it 'renders the posts/index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe 'GET #show' do
      it 'does not require authentication' do
        @post = create(:post, title: 'Correct')
        get :show, id: @post.id
        expect(response).to be_success
      end

      it 'fetches the correct post' do
        @post = create(:post, title: 'Correct')
        get :show, id: @post.id
        @post.title.should == 'Correct'
      end

      it 'raises a RecordNotFound error if post is unpublished' do
        post = create(:post, published_at: '2018-12-01 00:00:00')
        expect { get(:show, id: post.id) }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe 'GET #feed' do
      it 'renders posts/feed' do
        get :feed, format: :atom
        expect(response).to render_template 'posts/feed'
      end
    end

    describe 'GET #new' do
      it 'renders 404 page' do
        get :new
        expect(response).to render_template('errors/error_404')
      end
    end

    describe 'GET #edit' do
      before :each do
        post = create(:post)
        get :edit, id: post.id
      end

      it 'renders 404 page' do
        expect(response).to render_template('errors/error_404')
      end
    end

    describe 'POST #create' do
      it 'renders 404 page' do
        post :create, post: attributes_for(:post)
        expect(response).to render_template('errors/error_404')
      end
    end

    describe 'PUT #update' do
      it 'renders 404 page' do
        post = create(:post)
        put :update, id: post.id, post: attributes_for(:post, name: 'No')
        expect(response).to render_template('errors/error_404')
      end
    end

    describe 'DELETE #destroy' do
      it 'renders 404 page' do
        post = create(:post)
        delete :destroy, id: post.id
        expect(response).to render_template('errors/error_404')
      end
    end
  end

  shared_examples('admin access to posts:') do
    before :each do
      login_admin
    end

    describe 'GET #new' do
      it 'renders posts/new template' do
        get :new
        expect(response).to render_template('posts/new')
      end
    end

    describe 'GET #edit' do
      it 'renders posts/new template' do
        post = create(:post)
        get :edit, id: post.id
        expect(response).to render_template('posts/edit')
      end
    end

    describe 'POST #create' do
      before :each do
        post :create, post: attributes_for(:post)
      end

      it 'creates a new post with the supplied (valid) attributes' do
        expect(Post.all.count).to eq(1)
      end

      it 'redirects to the new post' do
        expect(response).to redirect_to(Post.last)
      end
    end

    describe 'PUT #update' do
      before :each do
        @post = create(:post)
        put :update, id: @post.id, post: attributes_for(:post, title: 'Done')
      end

      it 'saves the post with the new attributes' do
        expect(@post.reload.title).to eq 'Done'
      end
    end

    describe 'DELETE #destroy' do
      before :each do
        @post = create(:post)
        delete :destroy, id: @post.id
      end

      it 'destroys the specified post' do
        expect(Post.all.count).to eq(0)
      end

      it 'redirects to the main blog page' do
        expect(response).to redirect_to blog_path
      end
    end
  end

  context 'when not logged in,' do
    it_behaves_like 'public access to posts:'
  end

  context 'when logged in as normal user,' do
    before :each do
      login_user
    end

    it_behaves_like 'public access to posts:'
  end

  context 'when logged in as admin,' do
    before :each do
      login_admin
    end

    it_behaves_like 'admin access to posts:'
  end
end
