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
            snap_store=False)))

        # Execute the snapstack tests
        plan = Plan(base_setup=setup.steps())
        plan.run()
