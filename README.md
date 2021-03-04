# Tezos sandboxed node

## Protocol activation

### Get current protocol

```
GET http://localhost:8732/chains/main/blocks/genesis/protocols
{ "protocol": "ProtoGenesisGenesisGenesisGenesisGenesisGenesk612im",
    "next_protocol": "ProtoGenesisGenesisGenesisGenesisGenesisGenesk612im" }
```

### Prepare protocol constants

In JSON form they look (at least for Edo) like the following:
```
{
  "bootstrap_accounts": [
    ["edpkuBknW28nW72KG6RoHtYW7p12T6GKc7nAbwYX5m8Wd9sDVC9yav", "4000000000000"],
    ["edpktzNbDAUjUk697W7gYg2CRuBQjyPxbEg8dLccYYwKSKvkPvjtV9", "4000000000000"],
    ["edpkuTXkJDGcFd5nh6VvMz8phXxU3Bi7h6hqgywNFi1vZTfQNnS1RV", "4000000000000"],
    ["edpkuFrRoDSEbJYgxRtLx2ps82UdaYc1WwfS9sE11yhauZt5DgCHbU", "4000000000000"],
    ["edpkv8EUUH68jmo3f7Um5PezmfGrRF24gnfLpH3sVNwJnV5bVCxL2n", "4000000000000"]
  ],
  "bootstrap_contracts": [],
  "commitments": [],
  "preserved_cycles": 2,
  "blocks_per_cycle": 8,
  "blocks_per_commitment": 4,
  "blocks_per_roll_snapshot": 4,
  "blocks_per_voting_period": 64,
  "time_between_blocks": [
    "1",
    "0"
  ],
  "endorsers_per_block": 32,
  "hard_gas_limit_per_operation": "1040000",
  "hard_gas_limit_per_block": "10400000",
  "proof_of_work_threshold": "70368744177663",
  "tokens_per_roll": "8000000000",
  "michelson_maximum_type_size": 1000,
  "seed_nonce_revelation_tip": "125000",
  "origination_size": 257,
  "block_security_deposit": "512000000",
  "endorsement_security_deposit": "64000000",
  "baking_reward_per_endorsement": [
    "1250000",
    "187500"
  ],
  "endorsement_reward": [
    "1250000",
    "833333"
  ],
  "cost_per_byte": "250",
  "hard_storage_limit_per_operation": "60000",
  "test_chain_duration": "1966080",
  "quorum_min": 2000,
  "quorum_max": 7000,
  "min_proposal_quorum": 500,
  "initial_endorsers": 1,
  "delay_per_missing_endorsement": "1"
}
```
In order to get bytes, prepend 4 byte prefix and then encode using BSON.

### Preapply a block header with protocol constants
Fitness is set to 1 (at the genesis).  
For signing use "edsk31vznjHSSpGExDMHYASz45VZqXN4DPxvsa4hAyY8dHM28cZzp6" private key aka "activator" or "dictator".

```
POST http://localhost:8732/chains/main/blocks/genesis/helpers/preapply/block?timestamp=1614845848
{ "protocol_data":
    { "protocol": "ProtoGenesisGenesisGenesisGenesisGenesisGenesk612im",
    "content":
        { "command": "activate",
        "hash": "PtEdo2ZkT9oKpimTah6x2embF25oss54njMuPzkJTEi5RqfdZFA",
        "fitness": [ "00", "0000000000000001" ],
        "protocol_parameters":
            "000005a4a405000004626f6f7473747261705f6163636f756e747300cc01000004300058000000023000370000006564706b75426b6e5732386e5737324b4736526f48745957377031325436474b63376e4162775958356d385764397344564339796176000231000e00000034303030303030303030303030000004310058000000023000370000006564706b747a4e624441556a556b36393757376759673243527542516a79507862456738644c63635959774b534b766b50766a745639000231000e00000034303030303030303030303030000004320058000000023000370000006564706b7554586b4a4447634664356e683656764d7a38706858785533426937683668716779774e466931765a5466514e6e53315256000231000e00000034303030303030303030303030000004330058000000023000370000006564706b754672526f445345624a59677852744c783270733832556461596331577766533973453131796861755a7435446743486255000231000e00000034303030303030303030303030000004340058000000023000370000006564706b76384555554836386a6d6f336637556d3550657a6d66477252463234676e664c70483373564e774a6e5635625643784c326e000231000e0000003430303030303030303030303000000004626f6f7473747261705f636f6e74726163747300050000000004636f6d6d69746d656e7473000500000000017072657365727665645f6379636c657300000000000000004001626c6f636b735f7065725f6379636c6500000000000000204001626c6f636b735f7065725f636f6d6d69746d656e7400000000000000104001626c6f636b735f7065725f726f6c6c5f736e617073686f7400000000000000104001626c6f636b735f7065725f766f74696e675f706572696f640000000000000050400474696d655f6265747765656e5f626c6f636b7300170000000230000200000031000231000200000030000001656e646f72736572735f7065725f626c6f636b00000000000000404002686172645f6761735f6c696d69745f7065725f6f7065726174696f6e0008000000313034303030300002686172645f6761735f6c696d69745f7065725f626c6f636b00090000003130343030303030000270726f6f665f6f665f776f726b5f7468726573686f6c64000f00000037303336383734343137373636330002746f6b656e735f7065725f726f6c6c000b0000003830303030303030303000016d696368656c736f6e5f6d6178696d756d5f747970655f73697a65000000000000408f4002736565645f6e6f6e63655f726576656c6174696f6e5f746970000700000031323530303000016f726967696e6174696f6e5f73697a6500000000000010704002626c6f636b5f73656375726974795f6465706f736974000a0000003531323030303030300002656e646f7273656d656e745f73656375726974795f6465706f73697400090000003634303030303030000462616b696e675f7265776172645f7065725f656e646f7273656d656e74002200000002300008000000313235303030300002310007000000313837353030000004656e646f7273656d656e745f726577617264002200000002300008000000313235303030300002310007000000383333333333000002636f73745f7065725f6279746500040000003235300002686172645f73746f726167655f6c696d69745f7065725f6f7065726174696f6e000600000036303030300002746573745f636861696e5f6475726174696f6e000800000031393636303830000171756f72756d5f6d696e000000000000409f400171756f72756d5f6d617800000000000058bb40016d696e5f70726f706f73616c5f71756f72756d000000000000407f4001696e697469616c5f656e646f727365727300000000000000f03f0264656c61795f7065725f6d697373696e675f656e646f7273656d656e740002000000310000" },
    "signature":
        "edsigtXomBKi5CTRf5cjATJWSyaRvhfYNHqSUGrn4SdbYRcGwQrUGjzEfQDTuqHhuA8b2d8NarZjz8TRf65WkpQmo423BtomS8Q" },
"operations": [] }
```

### Forge block header

```
block_header
************

+----------------------------+----------+---------------------------+
| Name                       | Size     | Contents                  |
+============================+==========+===========================+
| level                      | 4 bytes  | signed 32-bit integer     |
+----------------------------+----------+---------------------------+
| proto                      | 1 byte   | unsigned 8-bit integer    |
+----------------------------+----------+---------------------------+
| predecessor                | 32 bytes | bytes                     |
+----------------------------+----------+---------------------------+
| timestamp                  | 8 bytes  | signed 64-bit integer     |
+----------------------------+----------+---------------------------+
| validation_pass            | 1 byte   | unsigned 8-bit integer    |
+----------------------------+----------+---------------------------+
| operations_hash            | 32 bytes | bytes                     |
+----------------------------+----------+---------------------------+
| # bytes in field "fitness" | 4 bytes  | unsigned 30-bit integer   |
+----------------------------+----------+---------------------------+
| fitness                    | Variable | sequence of $fitness.elem |
+----------------------------+----------+---------------------------+
| context                    | 32 bytes | bytes                     |
+----------------------------+----------+---------------------------+
| protocol_data              | Variable | bytes                     |
+----------------------------+----------+---------------------------+


fitness.elem
************

+-----------------------+----------+-------------------------+
| Name                  | Size     | Contents                |
+=======================+==========+=========================+
| # bytes in next field | 4 bytes  | unsigned 30-bit integer |
+-----------------------+----------+-------------------------+
| Unnamed field 0       | Variable | bytes                   |
+-----------------------+----------+-------------------------+
```

### Inject a block

```
POST http://localhost:8732/injection/block
{ "data":
    "00000001018fcf233671b6a04fcf679d2a381c2544ea6c1ea29ba6157776ed8424c7ccd00b0000000060409798000e5751c026e543b2e8ab2eb06099daa1d1e5df47778f7787faab45cdf12fe3a80000001100000001000000000800000000000000016ca575288050e898b2cbb5214104be8ad84f9d46474f816e6067016f4a30ff4200c7ad4f7a000e28e9eefc58de8ea1172de843242bd2e688779953d3416a44640b000000110000000100000000080000000000000001000005a4a405000004626f6f7473747261705f6163636f756e747300cc01000004300058000000023000370000006564706b75426b6e5732386e5737324b4736526f48745957377031325436474b63376e4162775958356d385764397344564339796176000231000e00000034303030303030303030303030000004310058000000023000370000006564706b747a4e624441556a556b36393757376759673243527542516a79507862456738644c63635959774b534b766b50766a745639000231000e00000034303030303030303030303030000004320058000000023000370000006564706b7554586b4a4447634664356e683656764d7a38706858785533426937683668716779774e466931765a5466514e6e53315256000231000e00000034303030303030303030303030000004330058000000023000370000006564706b754672526f445345624a59677852744c783270733832556461596331577766533973453131796861755a7435446743486255000231000e00000034303030303030303030303030000004340058000000023000370000006564706b76384555554836386a6d6f336637556d3550657a6d66477252463234676e664c70483373564e774a6e5635625643784c326e000231000e0000003430303030303030303030303000000004626f6f7473747261705f636f6e74726163747300050000000004636f6d6d69746d656e7473000500000000017072657365727665645f6379636c657300000000000000004001626c6f636b735f7065725f6379636c6500000000000000204001626c6f636b735f7065725f636f6d6d69746d656e7400000000000000104001626c6f636b735f7065725f726f6c6c5f736e617073686f7400000000000000104001626c6f636b735f7065725f766f74696e675f706572696f640000000000000050400474696d655f6265747765656e5f626c6f636b7300170000000230000200000031000231000200000030000001656e646f72736572735f7065725f626c6f636b00000000000000404002686172645f6761735f6c696d69745f7065725f6f7065726174696f6e0008000000313034303030300002686172645f6761735f6c696d69745f7065725f626c6f636b00090000003130343030303030000270726f6f665f6f665f776f726b5f7468726573686f6c64000f00000037303336383734343137373636330002746f6b656e735f7065725f726f6c6c000b0000003830303030303030303000016d696368656c736f6e5f6d6178696d756d5f747970655f73697a65000000000000408f4002736565645f6e6f6e63655f726576656c6174696f6e5f746970000700000031323530303000016f726967696e6174696f6e5f73697a6500000000000010704002626c6f636b5f73656375726974795f6465706f736974000a0000003531323030303030300002656e646f7273656d656e745f73656375726974795f6465706f73697400090000003634303030303030000462616b696e675f7265776172645f7065725f656e646f7273656d656e74002200000002300008000000313235303030300002310007000000313837353030000004656e646f7273656d656e745f726577617264002200000002300008000000313235303030300002310007000000383333333333000002636f73745f7065725f6279746500040000003235300002686172645f73746f726167655f6c696d69745f7065725f6f7065726174696f6e000600000036303030300002746573745f636861696e5f6475726174696f6e000800000031393636303830000171756f72756d5f6d696e000000000000409f400171756f72756d5f6d617800000000000058bb40016d696e5f70726f706f73616c5f71756f72756d000000000000407f4001696e697469616c5f656e646f727365727300000000000000f03f0264656c61795f7065725f6d697373696e675f656e646f7273656d656e740002000000310000a310f30c557680436dbf5e959eba5e679d93562e441c5fcf812fd0502eea64839d432737518551d50858a3371cf07cf3560b20d0590032dbdca55a8734995b0c",
"operations": [] }

```