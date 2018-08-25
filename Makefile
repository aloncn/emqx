.PHONY: plugins tests

PROJECT = emqx
PROJECT_DESCRIPTION = EMQ X Broker
PROJECT_VERSION = 3.0

DEPS = jsx gproc gen_rpc lager ekka esockd cowboy clique

dep_jsx     = git https://github.com/talentdeficit/jsx 2.9.0
dep_gproc   = git https://github.com/uwiger/gproc 0.8.0
dep_gen_rpc = git https://github.com/emqx/gen_rpc 2.1.1
dep_lager   = git https://github.com/erlang-lager/lager 3.6.4
dep_esockd  = git https://github.com/emqx/esockd emqx30
dep_ekka    = git https://github.com/emqx/ekka emqx30
dep_cowboy  = git https://github.com/ninenines/cowboy 2.4.0
dep_clique  = git https://github.com/emqx/clique

NO_AUTOPATCH = gen_rpc cuttlefish

ERLC_OPTS += +debug_info
ERLC_OPTS += +'{parse_transform, lager_transform}'

BUILD_DEPS = cuttlefish
dep_cuttlefish = git https://github.com/emqx/cuttlefish emqx30

TEST_DEPS = emqx_ct_helplers
dep_emqx_ct_helplers = git git@github.com:emqx/emqx-ct-helpers

TEST_ERLC_OPTS += +debug_info
TEST_ERLC_OPTS += +'{parse_transform, lager_transform}'

EUNIT_OPTS = verbose

CT_SUITES = emqx_inflight
## emqx_trie emqx_router emqx_frame emqx_mqtt_compat

#CT_SUITES = emqx emqx_broker emqx_mod emqx_lib emqx_topic emqx_mqueue emqx_inflight \
#			emqx_vm emqx_net emqx_protocol emqx_access emqx_router

CT_OPTS = -cover test/ct.cover.spec -erl_args -name emqxct@127.0.0.1

COVER = true

PLT_APPS = sasl asn1 ssl syntax_tools runtime_tools crypto xmerl os_mon inets public_key ssl lager compiler mnesia
DIALYZER_DIRS := ebin/
DIALYZER_OPTS := --verbose --statistics -Werror_handling -Wrace_conditions #-Wunmatched_returns

include erlang.mk

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emqx.conf -i priv/emqx.schema -d data/

