defmodule Blog.PostTest do
  use Blog.DataCase

  alias Blog.Post

  describe "changeset/2" do

    @tag :unit
    test "should be valid if params are correct for post" do
      attrs = build(:post)
      post = Post.changeset(%Post{}, attrs)
      assert post.valid?
    end

    @tag :unit
    test "should not add post if it does not contain all the required info" do
      attrs = %{ title: "oh man, oh jeez", short_text: "oh", body: "oh man\\\\" }
      post = Post.changeset(%Post{}, attrs)
      refute post.valid?
    end

    @tag :unit
    test "should not add if short_text has more than 140 chars" do
      attrs = build(:post,
        %{ short_text:
          "fjdkfjdkjfdjfdkfjdjfdkjfdkjfdkjfdkjfdkfdkfdjf
            fjdkslajfl;dksajfl;dsja;lfkjdas
            fdjksfjdkfjdkfjdkf
            fdjkfjdkfjdkjfdkjfdkfdlfjsklfjldksjafds
            fjdkslfjdklsjfldksjflksdjfldksjfskldjfdskljflksdjfds
            fdjkfjdkjfkdlsjflkdsjfkldsjflkdsjfkdsjlfdsjfkldsj
            fdjsklfjdskjfdsklfjkdlsj fjdskljfdsklfjsdkjfdkls fjldksjfklsdjflsd
            fjsdlfjsdklfjsldkjfklsdjfskld fjsdkljfsdkljflsdkjf
            fjdsklfjsdklfjsdlk fjklsdjfsldkjfskdljfs fsdklfjdslkjfsldk
            fjkdsljfskldjflskdjfsdlkfjdslkjfsd
          djfdfdfkjdkfjdkfdkfjdjfdjfkdjfd"
          })
      post = Post.changeset(%Post{}, attrs)
      refute post.valid?
    end

  end
end
