/*
 * $HEADER$
 */
#if defined(c_plusplus) || defined(__cplusplus)
extern "C" {
#endif

extern const mca_base_component_t mca_event_libevent2021_component;

const mca_base_component_t *mca_event_base_static_components[] = {
  &mca_event_libevent2021_component, 
  NULL
};

#if defined(c_plusplus) || defined(__cplusplus)
}
#endif

