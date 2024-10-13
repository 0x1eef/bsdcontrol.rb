# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class SysDefTest < BSD::Control::Test
    def test_sysdef!_insufficient_permissions
      assert_raises(Errno::EPERM) { feature(:pageexec).sysdef!(file) }
    end

    private

    def feature(name)
      BSD::Control.feature(name)
    end
  end
end
