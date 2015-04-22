FactoryGirl.define do
  factory :asset do
    title 'A File Uploaded'
    description 'A descriptive sentence.'
    caption 'The short caption.'

    factory :image do
      asset File.open(File.join(Rails.root, '/spec/files/test_image.jpg'))
    end
  end
end
