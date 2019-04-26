defmodule Blog.CommenTest do
  use Blog.DataCase
  import Blog.Factory

  alias Blog.Comment

  describe "changeset/2" do
    @tag :unit
    test "should be valid if params are correct" do
      attrs = build(:comment)
      comment = Comment.changeset(%Comment{}, attrs)
      assert comment.valid?
    end

    @tag :unit
    test "should not add a comment that does not have the required field" do
      attrs = %{ email: "oh@man.com" }
      comment = Comment.changeset(%Comment{}, attrs)
      refute comment.valid?
    end

    @tag :unit
    test "should not add a comment that does not have a valid e-mail" do
      attrs = build(:comment, %{ email: "oi.com"})
      comment = Comment.changeset(%Comment{}, attrs)
      refute comment.valid?
    end

  end
end
