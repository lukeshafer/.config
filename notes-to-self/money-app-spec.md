# Money App Spec

## Requirements

Create an application for tracking tattoo business income and expenses, converted from the existing accounting spreadsheet

### Goals
* Easy to use on mobile and PC (but esp mobile)

## Open questions

* Is the "Account" field actually helpful? Is she not picking it because it's annoying in excel or because that info isn't helpful to her
    - i lean towards using it still but making it less annoying to pick (could be a checkbox instead of a select)

* Do we want to track category for income? Definitely for expense for taxes but income not necessarily required

## Tech stuff

* Requires valid auth, login w Google
* Probably just use SST+Solid Start for simplicity (and bc I already started)

## Design

### Colors and Font

Brand Color: #044032
Neutral Color: #E6C8AA

Sans Serif font(s)

### Pages
  * New Transaction
  * Transactions
  * Reports
  * Config

#### New Transaction

Form for submitting new transaction. 

[(INCOME)]|[(EXPENSE)]

(income)
Date
[2/18/2026]

Client
[Name goes here]

Amount
[$123.45]

Payment method
<!-- if multiple are selected, a text box will allow splitting the amount between payment methods -->
[ ] Novo
[ ] Paypal
[ ] Cash
[ ] Venmo
[ ] Venue
[ ] Other

Category
<!-- TODO: double check if this is wanted -->
( ) Tattoo payment
( ) Deposit
( ) Account Transfer
( ) Other 
<!-- if Other is selected, include an optional text box for name and an option to save as new category -->

Notes
[ TEXTAREA CONTENT ]

[(SUBMIT)]

(expense)
Date
[2/18/2026]

Name/description
[Name goes here]

Amount
[$123.45]

Payment method
<!-- if multiple are selected, a text box will allow splitting the amount between payment methods -->
[ ] Novo
[ ] Paypal
[ ] Cash
[ ] Venmo
[ ] Venue
[ ] Other

Category
( ) Supplies
( ) Marketing
( ) Rent
( ) Equipment
( ) Account Transfer
( ) Other
<!-- if Other is selected, include an optional text box for name and an option to save as new category -->

Notes
[ TEXTAREA CONTENT ]

[(SUBMIT)]

#### Transactions

* 3 modes: Income, expenses, all
* Sorting/filter options on table
* Simple view for mobile:
    - Date, Name, Amount
* Full view for desktop (optional on mobile):
    - All (relevant) fields
* Default: sort by date, descending (newest first)

Otherwise, it's a pretty generic table spreadsheet-like view

#### Reports

Initially, just P&L with a printable layout
Can add additional reports in the future

Date Range field that auto-loads the data for the given range

Shortcut buttons
* This month (default)
* Last month
* Month-to-date
* Year-to-date
* Last year 

Buttons for relative dates (e.g. Last/This year/month) should auto include the relevant date
e.g. 
    "Last Month (Jan)"
    "This Month (Feb)"
    "Last Year (2025)"

#### Config

Basically the same as the spreadsheet config. Options include:

Income categories
Expense categories
Money Accounts

Auth accounts? Like authorized Google accounts?

### DB Design

Primarily transactions and customers.
Transaction amounts should be line items, i.e. its own entity, to include when split between accounts

#### Entities

* Transaction
    transactionId
    transactionType (income/expense)
    customerId
    date
    notes
    category
* TransactionItem
    transactionId
    transactionType (for queries)
    lineNumber
    account
    amount
* Customer
    customerId
    name
    foundVia? (i.e. how customer found the business)
(even though we have transaction items, they will only be displayed to the user when a transaction has multiple accounts)
