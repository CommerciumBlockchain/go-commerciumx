// Copyright 2014 The go-CommerciumX Authors
// This file is part of go-CommerciumX.
//
// go-CommerciumX is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// go-CommerciumX is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with go-CommerciumX. If not, see <http://www.gnu.org/licenses/>.

// evm executes EVM code snippets.
package main

import (
	"fmt"
	"math/big"
	"os"

	"github.com/CommerciumBlockchain/go-CommerciumX/cmd/utils"
	"gopkg.in/urfave/cli.v1"
)

var gitCommit = "" // Git SHA1 commit hash of the release (set via linker flags)

var (
	app = utils.NewApp(gitCommit, "the evm command line interface")

	DebugFlag = cli.BoolFlag{
		Name:  "debug",
		Usage: "output full trace logs",
	}
	MemProfileFlag = cli.StringFlag{
		Name:  "memprofile",
		Usage: "creates a memory profile at the given path",
	}
	CPUProfileFlag = cli.StringFlag{
		Name:  "cpuprofile",
		Usage: "creates a CPU profile at the given path",
	}
	StatDumpFlag = cli.BoolFlag{
		Name:  "statdump",
		Usage: "displays stack and heap memory information",
	}
	CodeFlag = cli.StringFlag{
		Name:  "code",
		Usage: "EVM code",
	}
	CodeFileFlag = cli.StringFlag{
		Name:  "codefile",
		Usage: "File containing EVM code. If '-' is specified, code is read from stdin ",
	}
	GasFlag = cli.Uint64Flag{
		Name:  "gas",
		Usage: "gas limit for the evm",
		Value: 10000000000,
	}
	PriceFlag = utils.BigFlag{
		Name:  "price",
		Usage: "price set for the evm",
		Value: new(big.Int),
	}
	ValueFlag = utils.BigFlag{
		Name:  "value",
		Usage: "value set for the evm",
		Value: new(big.Int),
	}
	DumpFlag = cli.BoolFlag{
		Name:  "dump",
		Usage: "dumps the state after the run",
	}
	InputFlag = cli.StringFlag{
		Name:  "input",
		Usage: "input for the EVM",
	}
	VerbosityFlag = cli.IntFlag{
		Name:  "verbosity",
		Usage: "sets the verbosity level",
	}
	CreateFlag = cli.BoolFlag{
		Name:  "create",
		Usage: "indicates the action should be create rather than call",
	}
	DisableGasMeteringFlag = cli.BoolFlag{
		Name:  "nogasmetering",
		Usage: "disable gas metering",
	}
	GenesisFlag = cli.StringFlag{
		Name:  "prestate",
		Usage: "JSON file with prestate (genesis) config",
	}
	MachineFlag = cli.BoolFlag{
		Name:  "json",
		Usage: "output trace logs in machine readable format (json)",
	}
	SenderFlag = cli.StringFlag{
		Name:  "sender",
		Usage: "The transaction origin",
	}
	ReceiverFlag = cli.StringFlag{
		Name:  "receiver",
		Usage: "The transaction receiver (execution context)",
	}
	DisableMemoryFlag = cli.BoolFlag{
		Name:  "nomemory",
		Usage: "disable memory output",
	}
	DisableStackFlag = cli.BoolFlag{
		Name:  "nostack",
		Usage: "disable stack output",
	}
)

func init() {
	app.Flags = []cli.Flag{
		CreateFlag,
		DebugFlag,
		VerbosityFlag,
		CodeFlag,
		CodeFileFlag,
		GasFlag,
		PriceFlag,
		ValueFlag,
		DumpFlag,
		InputFlag,
		DisableGasMeteringFlag,
		MemProfileFlag,
		CPUProfileFlag,
		StatDumpFlag,
		GenesisFlag,
		MachineFlag,
		SenderFlag,
		ReceiverFlag,
		DisableMemoryFlag,
		DisableStackFlag,
	}
	app.Commands = []cli.Command{
		compileCommand,
		disasmCommand,
		runCommand,
		stateTestCommand,
	}
}

func main() {
	if err := app.Run(os.Args); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
