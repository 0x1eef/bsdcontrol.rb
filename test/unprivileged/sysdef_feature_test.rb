# frozen_string_literal: true

require_relative "../setup"
module BSD::Control
  class SysDefTest < BSD::Control::Test
    def test_sysdef!_insufficient_permissions
      assert_raises(Errno::EPERM) do
        BSD::Control.feature(:pageexec).sysdef!(file)
      end
    end
  end
end
