require 'spec_helper'

describe Effective::EmailTemplate do

  let(:recipient) { "recipient@example.com" }

  it 'stores a precompiled template' do
    email = build(:email_template)
    expect(email.template).to eq(nil)

    email.precompile

    expect(email.template).not_to be(nil)
  end

  it 'loads a precompiled template' do
    email = create(:email_template)
    expect(Marshal.load(email.template)).to be_a(Liquid::Template)
  end

  it 'knows how to render itself' do
    email = create(:email_template)
    expect(email.render).to be_a(String)
  end

  it 'raises an error if a user attempts to set the template attribute directly' do
    email = build(:email_template)
    expect {
      email.template = email.body
    }.to raise_exception(Effective::RestrictedAttributeAccess)
  end

  it 'prepares a mail object' do
    email = create(:email_template)
    render_options = {}
    expect( email.prepare(recipient, render_options) ).to be_a(Mail::Message)
  end
end
