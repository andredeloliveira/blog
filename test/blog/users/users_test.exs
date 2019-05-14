defmodule Blog.UsersTest do
  use Blog.DataCase
  alias Blog.Users

  describe "create_user/1" do
    @tag :unit
    test "should create a user if params are correct" do
      attrs = build(:user)
      assert {:ok, user} = Users.create_user(attrs)
      assert user.email == attrs.email
    end

    @tag :unit
    test "should not create a user if password mismatch" do
      attrs = %{email: "not@valid.com", password: "wow5man", password_confirmation: "wowman"}
      assert {:error, %Ecto.Changeset{}} = Users.create_user(attrs)
    end
  end

  describe "authenticate_user/2" do
    @tag :unit
    test "should authenticate a user if it exists and email and password are correct" do
      attrs = build(:user)
      {:ok, user} = Users.create_user(attrs)
      assert {:ok, auth_user} = Users.authenticate_user(attrs.email, attrs.password)
    end

    @tag :unit
    test "should not authenticate a user if password mismatch" do
      {:ok, user} = Users.create_user(build(:user))

      assert {:error, "Incorrect email or password"} =
               Users.authenticate_user(user.email, "not_right_one")
    end
  end

  describe "get_user/1" do
    @tag :unit
    test "should get a user if params are correct" do
      {:ok, user} = Users.create_user(build(:user))
      assert {:ok, found_user} = Users.get_user(user.uuid)
      assert found_user.email == user.email
    end

    @tag :unit
    test "should return an error if user does not exist" do
      assert {:error, :not_found, :user, "123"} = Users.get_user("123")
    end
  end
end
