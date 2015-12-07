require 'helper'

describe Yotpo::Question do

  describe '#send_confirmation_mail' do
    before(:all) do
      question = {
          app_key: @app_key,
          product_id: 'D-4771',
          product_title: 'Product Title',
          product_url: 'https://www.google.com/?q=pforducturl',
          user_display_name: 'User Name',
          user_email: 'user@email.com',
          review_body: 'Integer feugiat nunc non leo vehicula bibendum. Nulla at tortor at nulla faucibus suscipit. Curabitur sodales est vel orci lobortis convallis. Vestibulum sit amet tellus neque, ac euismod arcu. Phasellus a nunc ultrices erat condimentum facilisis. Donec a odio in ligula vestibulum lobortis. Mauris posuere, justo tincidunt tincidunt interdum, felis velit venenatis augue, vel rhoncus purus turpis ut magna. Quisque consequat elit vitae enim molestie mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur adipiscing consequat lectus eu pulvinar. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae' ,
          review_source: 'widget_v2',
          product_description: 'Nullam ultrices purus a metus porttitor hendrerit. Vivamus accumsan congue urna a viverra. Nam molestie euismod est, vitae sollicitudin velit scelerisque vel. Quisque feugiat, metus sed tempus malesuada, quam erat volutpat metus, a tempor felis est id purus. Ut nec felis nunc, id cursus magna. Mauris sollicitudin ultrices velit vitae viverra. Nulla faucibus lacus id nisl euismod porta. Curabitur mi magna, tempus tristique commodo sit amet, imperdiet in eros. Proin eros arcu, ornare in lobortis eu, posuere ut risus. Quisque fermentum varius nibh, id aliquet lectus congue quis. In placerat arcu at libero posuere eleifend. Donec lacinia mollis lacus, at aliquam nisi molestie nec. Cras eleifend gravida nulla, vitae mollis eros varius eleifend. Pellentesque elit sem, lacinia eget fringilla vitae, condimentum eu quam. Proin quis orci arcu, ut suscipit arcu.',
          product_image_url: 'https://www.google.com/images/srpr/logo4w.png',
          }
      VCR.use_cassette('send_question_confirmation_email') do
        @response = Yotpo.send_confirmation_mail(question)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

  describe '#create_by_token' do
    before(:all) do
      question = {
          content: 'Integer feugiat nunc non leo vehicula bibendum. Nulla at tortor at nulla faucibus suscipit. Curabitur sodales est vel orci lobortis convallis. Vestibulum sit amet tellus neque, ac euismod arcu. Phasellus a nunc ultrices erat condimentum facilisis. Donec a odio in ligula vestibulum lobortis. Mauris posuere, justo tincidunt tincidunt interdum, felis velit venenatis augue, vel rhoncus purus turpis ut magna. Quisque consequat elit vitae enim molestie mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur adipiscing consequat lectus eu pulvinar. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae' ,
          product_description: 'Nullam ultrices purus a metus porttitor hendrerit. Vivamus accumsan congue urna a viverra. Nam molestie euismod est, vitae sollicitudin velit scelerisque vel. Quisque feugiat, metus sed tempus malesuada, quam erat volutpat metus, a tempor felis est id purus. Ut nec felis nunc, id cursus magna. Mauris sollicitudin ultrices velit vitae viverra. Nulla faucibus lacus id nisl euismod porta. Curabitur mi magna, tempus tristique commodo sit amet, imperdiet in eros. Proin eros arcu, ornare in lobortis eu, posuere ut risus. Quisque fermentum varius nibh, id aliquet lectus congue quis. In placerat arcu at libero posuere eleifend. Donec lacinia mollis lacus, at aliquam nisi molestie nec. Cras eleifend gravida nulla, vitae mollis eros varius eleifend. Pellentesque elit sem, lacinia eget fringilla vitae, condimentum eu quam. Proin quis orci arcu, ut suscipit arcu.',
          product_image_url: 'https://www.google.com/images/srpr/logo4w.png',
          product_name: 'Product Title',
          product_url: 'https://www.google.com/?q=pforducturl',
          product_id:'D-4771',
          token: '487e5b76efabbdee499753cf68d35d700f9f2b14',
          utm_campaign: 'general',
          utm_medium: 'general',
          utm_source: 'yotpo'
      }
      VCR.use_cassette('create_by_token') do
        @response = Yotpo.create_by_token(question)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

end