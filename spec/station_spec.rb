require 'station'

describe Station do
  it { expect(subject).to be_instance_of Station }
  it { expect(subject).to respond_to(:name) }
  it { expect(subject).to respond_to(:zone) }
end
