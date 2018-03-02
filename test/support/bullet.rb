Bullet.enable = true
Bullet.raise = true

module MinitestUsesBullet
  def before_setup
    Bullet.start_request
    super if defined?(super)
  end

  def after_teardown
    super if defined?(super)
    Bullet.end_request
  end

  def assert_no_bullet_warnings
    if Bullet.warnings.any?
      warnings = Bullet.warnings.map { |_, warning| warning }.flatten.map(&:body).join("\n-----\n\n")
      flunk "\nBullet warnings: \n\n#{warnings}"
    end
  end
end

module Minitest
  class Test
    include MinitestUsesBullet
  end
end
