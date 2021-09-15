# QBCORE | COUPONS - REDEEM | Create Coupon Codes for your Players or let Tebex do it! 
# players can redeem ingame!
## Setup
1. Run the SQL File 
2. Put the Script in your resources, and start it in cfg file. 
### How to use with TEBEX 
1. Link your DATABASE to Tebex as a game server.
2. Add in this as the command - 
```sql
INSERT INTO `codes` VALUES ('{transaction}-7' , 'item-name or money', 'AMOUNT', '0', 'TEBEX', NULL);
```
# Example for item
```sql
INSERT INTO `codes` VALUES ('{transaction}-7' , 'donorcoin', '2', '0', 'TEBEX', NULL);
```
# Example for Money
```sql
INSERT INTO `codes` VALUES ('{transaction}-8' , 'money', '4000000', '0', 'TEBEX', NULL);
```
Same as example below make sure they are in ''s and that AMOUNT is a number.
3. **Make Sure to put -(Number) at the end like i have -7 on this one for EACH item/code Given. And then tell your customers that to redeem they just type in the tebex transID and the -7 or whatever number(s) it is for that package.**
4. Example of how to redeem a tebex transaction - /redeem tbx-43725621a42940-35b945-7 

## Tebex example 
https://imgur.com/f9IIQZ3
## Commands
- `/createcode [type] [amount]` - Creates a Code (Only for GOD Level Holder)
- `/redeem [code]` - Redeem a Given Code
- Where [type] can be `money` or `item-name`

## Examples
`/createcode money 50000` // returns code with Rewards as 50K

`/createcode electronic_kit 15` // returns code with Rewards 15 Electronic Kits

`/redeem un$i9KuZmV` // redeems code

