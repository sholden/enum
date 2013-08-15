require 'spec_helper'

describe BitflagEnum do
  let(:enum) { BitflagEnum.new(:global, :group, :user) }

  describe ".[]" do
    it "looks up a number by symbol" do
      enum[:group].should == 2
    end

    it "looks up a symbol by number" do
      enum[4].should == :user
    end
  end

  context "bitwise operations" do
    let(:flags) { enum[:group] | enum[:user]}

    it 'can check presence of a flag' do
      (flags & enum[:group]).should == enum[:group]
      (flags & enum[:user]).should == enum[:user]
      (flags & enum[:global]).should_not == enum[:global]
    end

    it 'can check presence of multiple flags' do
      (flags & (enum[:group] | enum[:user])).should == enum[:group] | enum[:user]
      (flags & (enum[:global] | enum[:group])).should_not == enum[:global] | enum[:group]
    end

    it 'can add flags' do
      with_global = flags | enum[:global]
      (with_global & enum[:global]).should == enum[:global]
    end

    it 'can remove flags' do
      without_user = flags ^ enum[:user]
      (without_user & enum[:user]).should_not == enum[:user]
    end
  end
end
