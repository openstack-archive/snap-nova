import unittest

from snapstack import Plan, Setup, Step

class SnapstackTest(unittest.TestCase):

    def test_snapstack(self):
        '''
        _test_snapstack_

        Run a basic smoke test, utilizing our snapstack testing harness.

        '''
        # Setup override in base.Setup for locally built nova.
        setup = Setup()
        setup.add_steps(('nova', Step(
            snap='nova',
            script_loc='./tests/',
            scripts=['nova.sh'],
            snap_store=False)))

        # Execute the snapstack tests
        plan = Plan(base_setup=setup.steps())        
        plan.run()
