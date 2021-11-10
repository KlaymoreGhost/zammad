// Copyright (C) 2012-2021 Zammad Foundation, https://zammad-foundation.org/

import { shallowMount } from '@vue/test-utils'
import CommonHelloWorld from '@common/components/CommonHelloWorld.vue'

describe('CommonHelloWorld.vue', () => {
  it('renders props.msg when passed', () => {
    const msg = 'new message'
    const wrapper = shallowMount(CommonHelloWorld, {
      props: { msg, show: true },
    })
    expect(wrapper.text()).toMatch(msg)
  })
})
