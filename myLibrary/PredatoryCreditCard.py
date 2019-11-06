class PredatoryCreditCard(CreditCard):
	"""An extension to CreditCard that compound interst and fees."""

	def __init__(self, customer, bank, acnt, limit, apr):
		"""Create a new predatory credit card instance.

		The initial balance is zero.

		customer the name of the customer
		bank     the name of the bank
		acnt	 the acount identifier
		limit	 credit limit
		apr		 annual percentage rate
		"""
		super().__init__(customer, bank, acnt, limit)
		self._apr = apr

	def charge(self, price):
		"""Charge given price to the card, assuming sufficient credit limit.

		Return True if charge was processed.
		Return False and assess $5 fee if charge is denied.
		"""
		success = super().charge(price)
		if not success:
			self._balance += 5
		return success

	def process_month(self):
		"""Assess monthly interest on outstanding balance."""
		if self._balance > 0:
			monthly_factor = pow(1+self._apr, 1/12)
			self._balance *= monthly_factor