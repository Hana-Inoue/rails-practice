class User < ApplicationRecord
  enum gender: {
    men: 0,
    women: 1,
    others: 2
  }
end
