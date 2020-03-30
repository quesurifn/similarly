import React from 'react'
import _ from 'lodash'
import axios from 'axios'
import { Search, Modal, Button} from 'semantic-ui-react'

class Home extends React.PureComponent {
    constructor() {
        super()

        this.state = {
            isLoading: false,
            value: null,
            results: null,
            final: null,
            modal: false
        }

        this.toggle = this.toggle.bind(this)
    }

    handleResultSelect = (e, { result }) => this.setState({ final: result.title, value: result.title})

    handleSearchChange = async (e, { value })  => {
        this.setState({isLoading: true, value})
        const uri = `spotify/search?query=${value}`
        const results = await axios.get(uri)
        if(results.data.length > 0) this.setState({isLoading: false, results: results.data})
    }

    toggle() {
        const { modal } = this.state
        this.setState({modal: !modal})
    }

    componentDidMount() {
        const queryParams = window.location.search
        console.log(queryParams)
        if(queryParams.indexOf('oops') > -1) {
            this.toggle()
        }
    }

    render() {

        const { isLoading, value, results, final, modal } = this.state
        console.log(this.state)
        return (
            <div className={"fullscreen flex"}>
                <h1>Similarly</h1>
                <p>Show us your favorite song and we'll show you similar songs you'll like!</p>
                <div className={'search'}>
                    <Search
                        loading={isLoading}
                        onResultSelect={this.handleResultSelect}
                        onSearchChange={_.debounce(this.handleSearchChange, 500, {
                            leading: true,
                        })}
                        results={results}
                        value={value}
                        {...this.props}
                    />

                    {final &&
                    <a href={`/results?query=${btoa(final)}`}>
                        <Button positive>Find Similar Songs</Button>
                    </a>
                    }
                </div>


                <Modal
                    open={modal}
                    onClose={this.toggle}
                    closeOnEscape={this.toggle}
                    closeOnDimmerClick={this.toggle}
                >
                    <Modal.Header>Ooops...</Modal.Header>
                    <Modal.Content>
                        <p>We couldn't find any songs similar to this one. Maybe Last.fm forgot about it...</p>
                    </Modal.Content>
                    <Modal.Actions>
                        <Button onClick={this.toggle}>
                            Ok.
                        </Button>
                    </Modal.Actions>
                </Modal>
            </div>
        );
    }
}

export default Home;
