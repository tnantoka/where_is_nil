module WhereIsNil
  module ActiveRecord
    module Relation
      extend ActiveSupport::Concern

      included do
        alias_method :original_find_by, :find_by
        alias_method :original_find_by!, :find_by!

        def find_by(*args)
          if WhereIsNil.config.enabled && find_by_nil?(args)
            warning_log(args)
            raise_error(args)
            return nil if WhereIsNil.config.not_found
          end
          original_find_by(*args)
        end

        def find_by!(*args)
          if WhereIsNil.config.enabled && find_by_nil?(args)
            warning_log(args)
            raise_error(args)
            raise ::ActiveRecord::RecordNotFound if WhereIsNil.config.not_found
          end
          original_find_by!(*args)
        end

        private
          def find_by_nil?(args)
            arg = args.try(:first)
            arg.nil? || (Fixnum === arg && arg.to_i > 0)
          end

          def warning_log(args)
            return unless WhereIsNil.config.warning_log
            WhereIsNil.logger.warn error_message(args)
          end

          def raise_error(args)
            return unless WhereIsNil.config.raise_error
            raise WhereIsNil::FindByNil.new(error_message(args))
          end

          def error_message(args)
            arg = args.first.nil? ? 'nil' : args.first.to_s
            "Why do you find by #{arg}? Did you mean `find_by(id: #{arg})`?"
          end
      end
    end
  end
end

ActiveRecord::Relation.send :include, WhereIsNil::ActiveRecord::Relation
