module RedmineRisks
  module Patches
    module ProjectPatch
      def self.included(base)
        base.has_many :risks, dependent: :destroy
      end
    end
  end
end
