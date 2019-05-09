defmodule Blog.UserTest do
  use Blog.DataCase
  alias Blog.User

  describe "register_changeset/2" do
    @tag :unit
    test "should validade changeset if the parameters are correct" do
      attrs = build(:user)
      user = User.register_changeset(%User{}, attrs)
      assert user.valid?
    end

    @tag :unit
    test "should not validade changeset if e-mail is invalid" do
      attrs = %{email: "ohman", password: "secret", password_confirmation: "secret"}
      user = User.register_changeset(%User{}, attrs)
      refute user.valid?
    end

    @tag :unit
    test "should not validate changeset if password dont match" do
      attrs = %{email: "ohman@gmail.com", password: "secret", password_confirmation: "noway"}
      user = User.register_changeset(%User{}, attrs)
      refute user.valid?
    end
  end
end
