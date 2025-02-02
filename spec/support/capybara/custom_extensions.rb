# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Capybara::Node::Element

  # This is an extension to each node to check if the element
  # is moving or in a fixed position. This is especially helpful
  # for animated elements that cause flanky tests.
  # NOTE: In CI env a special sleep is performed between checks
  # because animations can be slow.
  #
  # @param [Integer] checks the number of performed movement checks
  #
  # @example
  #  find('.clues-close').in_fixed_position.click
  # => waits till clues moved to final position and performs click afterwards
  #
  # @raise [RuntimeError] raised in case the element is
  #   still moving after max number of checks was passed
  #
  # @return [Capybara::Node::Element] the element/node
  def in_fixed_position(checks: 100, wait: 0.2)
    previous = native.location

    (checks + 1).times do
      sleep wait

      current = native.location

      return self if previous == current

      previous = current
    end

    raise "Element still moving after #{checks} checks"
  end
end

module ZammadCapybarActionDelegator
  def select(...)
    super.tap do
      await_empty_ajax_queue
    end
  end

  def click(...)
    super.tap do
      await_empty_ajax_queue
    end
  end

  def click_on(...)
    super.tap do
      await_empty_ajax_queue
    end
  end

  def click_link(...)
    super.tap do
      await_empty_ajax_queue
    end
  end

  def click_link_or_button(...)
    super.tap do
      await_empty_ajax_queue
    end
  end

  def click_button(...)
    super.tap do
      await_empty_ajax_queue
    end
  end

  def select_option(...)
    super.tap do
      await_empty_ajax_queue
    end
  end

  def send_keys(...)
    super.tap do
      await_empty_ajax_queue
    end
  end

  def hot_keys
    mac_platform? ? %i[control alt] : %i[control shift]
  end

  def magic_key
    mac_platform? ? :command : :control
  end

  def mac_platform?
    Gem::Platform.local.os.eql? 'darwin'
  end
end

module ZammadCapybarSelectorDelegator
  def find_field(...)
    ZammadCapybaraElementDelegator.new(element: super, context: self)
  end

  def find_button(...)
    ZammadCapybaraElementDelegator.new(element: super, context: self)
  end

  def find_by_id(...)
    ZammadCapybaraElementDelegator.new(element: super, context: self)
  end

  def find_link(...)
    ZammadCapybaraElementDelegator.new(element: super, context: self)
  end

  def find(...)
    ZammadCapybaraElementDelegator.new(element: super, context: self)
  end

  def first(...)
    ZammadCapybaraElementDelegator.new(element: super, context: self)
  end

  def all(...)
    super.map { |element| ZammadCapybaraElementDelegator.new(element: element, context: self) }
  end
end

class ZammadCapybaraSessionDelegator < SimpleDelegator
  extend Forwardable

  def_delegator :@context, :await_empty_ajax_queue

  include ZammadCapybarSelectorDelegator

  def initialize(context:, element:)
    @context = context

    super(element)
  end
end

class ZammadCapybaraElementDelegator < ZammadCapybaraSessionDelegator
  include ZammadCapybarActionDelegator
end

module CapybaraCustomExtensions
  include ZammadCapybarActionDelegator
  include ZammadCapybarSelectorDelegator

  def page(...)
    ZammadCapybaraSessionDelegator.new(element: super, context: self)
  end

  # Work around an issue with failures in Capybara if different specs of the same rspec run
  #   use using_session with the same name, e.g. :second_browser. Solve by prepending the test name.
  def using_session(name_or_session, &block)
    if !(name_or_session.is_a? Capybara::Session)
      # self.class.name refers to the RSpec test case.
      name_or_session = (self.class.name + "::#{name_or_session}").to_sym
    end
    Capybara.using_session(name_or_session, &block)
  end
end

RSpec.configure do |config|
  config.include CapybaraCustomExtensions, type: :system
end
