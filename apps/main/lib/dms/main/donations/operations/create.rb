require "dms/main/entities/donation"
require "dms/main/donations/validations/donation"

require 'dry-monads'
require "dry/matcher"
require "dry/matcher/either_matcher"
module Dms
  module Main
    module Donations
      module Operations
        class Create
          include Dry::Matcher.for(:call, with: Dry::Matcher::EitherMatcher)
          #include Main::Import[ "persistence.repositories.posts", ]

          def call(attributes)
            # Validation
            validation = Validations::DonationSchema.(attributes)
            if validation.success?
              puts "PASSED VALIDATION"
              Dry::Monads::Right(validation)
            else
              puts "FAILED VALIDATION"
              Dry::Monads::Left(validation)
            end
          end
        end
      end
    end
  end
end
__END__

require "admin/import"
require "admin/entities/post"
require "admin/posts/validation/form"
require "berg/matcher"

module Admin
  module Posts
    module Operations
      class Create
        include Admin::Import[
          "persistence.repositories.posts",
          "slugify",
          "persistence.post_color_picker",
        ]

        include Berg::Matcher

        def call(attributes)
          validation = Validation::Form.(attributes)

          if validation.success?
            post = Admin::Entities::Post.new(posts.create(prepare_attributes(validation.to_h)))
            Dry::Monads::Right(post)
          else
            Dry::Monads::Left(validation)
          end
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            slug: slugify.(attributes[:title], posts.method(:slug_exists?)),
            color: post_color_picker.()
          )
        end
      end
    end
  end
end

