require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title(""), I18n.t("application.applicationtittle")
    assert_equal full_title("Help | "),
      I18n.t("application.applicationc5helptitle")
  end
end
