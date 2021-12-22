import * as Types from '@common/graphql/types';

import gql from 'graphql-tag';
import * as VueApolloComposable from '@vue/apollo-composable';
import * as VueCompositionApi from 'vue';
export type ReactiveFunction<TParam> = () => TParam;

export const ApplicationConfigDocument = gql`
    query applicationConfig {
  applicationConfig {
    key
    value
  }
}
    `;

/**
 * __useApplicationConfigQuery__
 *
 * To run a query within a Vue component, call `useApplicationConfigQuery` and pass it any options that fit your needs.
 * When your component renders, `useApplicationConfigQuery` returns an object from Apollo Client that contains result, loading and error properties
 * you can use to render your UI.
 *
 * @param options that will be passed into the query, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/query.html#options;
 *
 * @example
 * const { result, loading, error } = useApplicationConfigQuery();
 */
export function useApplicationConfigQuery(options: VueApolloComposable.UseQueryOptions<Types.ApplicationConfigQuery, Types.ApplicationConfigQueryVariables> | VueCompositionApi.Ref<VueApolloComposable.UseQueryOptions<Types.ApplicationConfigQuery, Types.ApplicationConfigQueryVariables>> | ReactiveFunction<VueApolloComposable.UseQueryOptions<Types.ApplicationConfigQuery, Types.ApplicationConfigQueryVariables>> = {}) {
  return VueApolloComposable.useQuery<Types.ApplicationConfigQuery, Types.ApplicationConfigQueryVariables>(ApplicationConfigDocument, {}, options);
}
export type ApplicationConfigQueryCompositionFunctionResult = VueApolloComposable.UseQueryReturn<Types.ApplicationConfigQuery, Types.ApplicationConfigQueryVariables>;
export const ConfigUpdatedDocument = gql`
    subscription configUpdated {
  configUpdated {
    setting {
      key
      value
    }
  }
}
    `;

/**
 * __useConfigUpdatedSubscription__
 *
 * To run a query within a Vue component, call `useConfigUpdatedSubscription` and pass it any options that fit your needs.
 * When your component renders, `useConfigUpdatedSubscription` returns an object from Apollo Client that contains result, loading and error properties
 * you can use to render your UI.
 *
 * @param options that will be passed into the subscription, supported options are listed on: https://v4.apollo.vuejs.org/guide-composable/subscription.html#options;
 *
 * @example
 * const { result, loading, error } = useConfigUpdatedSubscription();
 */
export function useConfigUpdatedSubscription(options: VueApolloComposable.UseSubscriptionOptions<Types.ConfigUpdatedSubscription, Types.ConfigUpdatedSubscriptionVariables> | VueCompositionApi.Ref<VueApolloComposable.UseSubscriptionOptions<Types.ConfigUpdatedSubscription, Types.ConfigUpdatedSubscriptionVariables>> | ReactiveFunction<VueApolloComposable.UseSubscriptionOptions<Types.ConfigUpdatedSubscription, Types.ConfigUpdatedSubscriptionVariables>> = {}) {
  return VueApolloComposable.useSubscription<Types.ConfigUpdatedSubscription, Types.ConfigUpdatedSubscriptionVariables>(ConfigUpdatedDocument, {}, options);
}
export type ConfigUpdatedSubscriptionCompositionFunctionResult = VueApolloComposable.UseSubscriptionReturn<Types.ConfigUpdatedSubscription, Types.ConfigUpdatedSubscriptionVariables>;