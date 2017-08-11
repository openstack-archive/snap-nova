import unittest

from snapstack import Plan, Setup, Step

class SnapstackTest(unittest.TestCase):

    def test_snapstack(self):
        '''
        _test_snapstack_

        Run a basic smoke test, utilizing our snapstack testing harness.

        '''
        # snapstack already installs nova. Override the 'nova'
        # step with a locally built snap. neutron, keystone, etc. will still
        # be installed as normal from the store.
        setup = Setup()
        setup.add_steps(('nova', Step(
            snap='nova',
            script_loc='./tests/',
            scripts=['nova.sh'],
            files=[
                'etc/snap-nova/nova/nova.conf.d/nova-placement.conf',
                'etc/snap-nova/nova/nova.conf.d/scheduler.conf',
                'etc/snap-nova/nova/nova.conf.d/database.conf',
                'etc/snap-nova/nova/nova.conf.d/keystone.conf',
                'etc/snap-nova/nova/nova.conf.d/rabbitmq.conf',
                'etc/snap-nova/nova/nova.conf.d/neutron.conf',
            ],
            snap_store=False)))

        # Execute the snapstack tests
        plan = Plan(base_setup=setup.steps())
        plan.run()
