defmodule Blog.Factory do
  use ExMachina

  def post_factory do
    %{
      title: "Man I'm old, even being young",
      short_text: "It all began when I born. I was small, a baby and that happened!",
      body: "
        A bunch of text that I will copy from a Ipson from the internet, check this out:
        Mussum Ipsum, cacilds vidis litro abertis. Todo mundo vê os porris que eu tomo, mas ninguém vê os tombis que eu levo! Sapien in monti palavris qui num significa nadis i pareci latim.  Quem num gosta di mé, boa gentis num é. Quem num gosta di mim que vai caçá sua turmis!
        we also have some MD shit
        ```javascript
         //  oh man, code to show, oh jeez
         let es6 = 'es6';
         const x = () => `I dont know ${es6}`;
         x();
        ```
      ",
      tags: "code test a-lot loads no-space-word"
    }
  end

  def comment_factory do
    %{
      email: "andre@andre.com",
      name: "Andre",
      body: "I love turtles"
    }
  end

  def user_factory do
    %{
      email: "andre@andre.com",
      password: "secret",
      password_confirmation: "secret"
    }
  end
end
